# -*- Python -*-

load("@protobuf_archive//:protobuf.bzl", "cc_proto_library")
load("@protobuf_archive//:protobuf.bzl", "py_proto_library")
load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_cc_binary", "tf_cc_test", "tf_py_wrap_cc")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library", "tf_proto_library_cc", "tf_proto_library_py")


fold_cc_binary = tf_cc_binary
fold_cc_test = tf_cc_test
fold_cc_library = native.cc_library
#fold_py_wrap_cc = tf_py_wrap_cc


def fold_py_binary(srcs_version="PY2AND3", **kwargs):
  native.py_binary(srcs_version="PY2AND3", **kwargs)


def fold_py_library(srcs_version="PY2AND3", **kwargs):
  native.py_library(srcs_version="PY2AND3", **kwargs)


def fold_py_test(srcs_version="PY2AND3", **kwargs):
  native.py_test(srcs_version="PY2AND3", **kwargs)


def fold_py_extension(name, srcs=[], outs=[], deps=[]):
  fold_cc_library(name = name + "_cc", srcs = srcs, deps = deps)
  for out in outs:
    fold_cc_binary(name=outs[0], srcs=[], linkshared=1, deps=[":" + name + "_cc"])


def fold_proto_library(cc_name, py_name, srcs, cc_deps=[], py_deps=[], visibility=None, testonly=0):
#    tf_proto_library_cc(
#        name = cc_name,
#        srcs = srcs,
#        protodeps = cc_deps,
#        testonly = testonly,
#        visibility = visibility,
#    )
#
#    tf_proto_library_py(
#        name = py_name,
#        srcs = srcs,
#        protodeps = py_deps,
#        srcs_version = "PY2AND3",
#        testonly = testonly,
#        visibility = visibility,
#    )
  cc_proto_library(name=cc_name,
                   srcs=srcs,
                   deps=cc_deps,
                   cc_libs=["@protobuf_archive//:protobuf"],
                   protoc="@protobuf_archive//:protoc",
                   default_runtime="@protobuf_archive//:protobuf",
                   visibility=visibility,
                   testonly=testonly)
  py_proto_library(name=py_name,
                   srcs=srcs,
                   srcs_version = "PY2AND3",
                   deps=["@protobuf_archive//:protobuf_python"] + py_deps,
                   default_runtime="@protobuf_archive//:protobuf_python",
                   protoc="@protobuf_archive//:protoc",
                   visibility=visibility,
                   testonly=testonly)


def fold_tf_op_py(name, srcs, cc_deps=[], py_deps=[]):
  so_name = "_" + name + ".so"
  fold_cc_binary(name=so_name, srcs = [], linkshared = 1, deps=cc_deps)
  fold_py_library(name=name, srcs=srcs, data=[so_name], deps=py_deps)




# Bazel rules for building swig files.
def _fold_py_wrap_cc_impl(ctx):
  srcs = ctx.files.srcs
  if len(srcs) != 1:
    fail("Exactly one SWIG source file label must be specified.", "srcs")
  module_name = ctx.attr.module_name
  cc_out = ctx.outputs.cc_out
  py_out = ctx.outputs.py_out
  src = ctx.files.srcs[0]
  args = ["-c++", "-python"]
  args += ["-module", module_name]
  args += ["-l" + f.path for f in ctx.files.swig_includes]
  cc_include_dirs = depset()
  cc_includes = depset()
  for dep in ctx.attr.deps:
    cc_include_dirs += [h.dirname for h in dep.cc.transitive_headers]
    cc_includes += dep.cc.transitive_headers
  args += ["-I" + x for x in cc_include_dirs]
  args += ["-I" + ctx.label.workspace_root]
  args += ["-o", cc_out.path]
  args += ["-outdir", py_out.dirname]
  args += [src.path]
  outputs = [cc_out, py_out]
  ctx.action(executable=ctx.executable.swig_binary,
             arguments=args,
             mnemonic="PythonSwig",
             inputs=sorted(depset([src]) + cc_includes +
                           ctx.files.swig_includes),
             outputs=outputs,
             progress_message="SWIGing {input}".format(input=src.path))
  return struct(files=depset(outputs))

_fold_py_wrap_cc = rule(
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = True,
        ),
        "swig_includes": attr.label_list(
            cfg = "data",
            allow_files = True,
        ),
        "deps": attr.label_list(
            allow_files = True,
            providers = ["cc"],
        ),
        "module_name": attr.string(mandatory = True),
        "py_module_name": attr.string(mandatory = True),
        "swig_binary": attr.label(
            default = Label("@swig//:swig"),
            cfg = "host",
            executable = True,
            allow_files = True,
        ),
    },
    outputs = {
        "cc_out": "%{module_name}.cc",
        "py_out": "%{py_module_name}.py",
    },
    implementation = _fold_py_wrap_cc_impl,
)

def fold_py_wrap_cc(name, srcs, swig_includes=[], deps=[], copts=[], **kwargs):
  module_name = name.split("/")[-1]
  # Convert a rule name such as foo/bar/baz to foo/bar/_baz.so
  # and use that as the name for the rule producing the .so file.
  cc_library_name = "/".join(name.split("/")[:-1] + ["_" + module_name + ".so"])
  _fold_py_wrap_cc(
      name=name + "_py_wrap",
      srcs=srcs,
      swig_includes=swig_includes,
      deps=deps,
      module_name=module_name,
      py_module_name=name)

  native.cc_binary(
      name=cc_library_name,
      srcs=[module_name + ".cc"],
      copts=copts + ["-Wno-self-assign", "-Wno-write-strings"],
      linkopts=[],
      linkstatic=1,
      linkshared=1,
      deps=deps)
  native.py_library(name=name,
                    srcs=[":" + name + ".py"],
                    srcs_version="PY2AND3",
                    data=[":" + cc_library_name])



