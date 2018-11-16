load("@protobuf_archive//:protobuf.bzl", "proto_gen")
load("@org_tensorflow//tensorflow/core:platform/default/build_config_root.bzl", "if_static")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "cc_proto_library", "tf_deps")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "py_proto_library")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library", "tf_proto_library_cc", "tf_proto_library_py")

load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_cc_binary", "tf_cc_test", "tf_py_wrap_cc", "if_not_windows")


#fold_proto_library = tf_proto_library
def fold_proto_library(name, srcs, cc_deps=[], protodeps=[], visibility = [], cc_libs=[]):
#  tf_proto_library_cc(
#    name = name,
#    srcs = srcs,
##    cc_libs=["@protobuf_archive//:protobuf"],
#    cc_libs=["@protobuf_archive//:protobuf_headers"],
#    protodeps = protodeps,
#  )
  cc_proto_library(name=name + "_cc",
                   srcs=srcs,
                   deps=cc_deps + ["@protobuf_archive//:cc_wkt_protos"],
                   cc_libs=["@protobuf_archive//:protobuf"],
                   visibility = visibility,
                   )
#  use_grpc_plugin = None
#  cc_deps = tf_deps(protodeps, "_cc")
#  cc_name = name + "_cc"
#  cc_proto_library(
#      name = cc_name,
#      srcs = srcs,
#      deps = cc_deps + ["@protobuf_archive//:cc_wkt_protos"],
#      cc_libs = cc_libs + if_static(
#          [
#            "@protobuf_archive//:protobuf"
#          ],
#          [
#            "@protobuf_archive//:protobuf_headers"
#          ],
#      ),
#      copts = if_not_windows([
#          "-Wno-unknown-warning-option",
#          "-Wno-unused-but-set-variable",
#          "-Wno-sign-compare",
#      ]),
#      protoc = "@protobuf_archive//:protoc",
#      use_grpc_plugin = use_grpc_plugin,
#      testonly = 0,
#      visibility = visibility,
#      default_header = False,
#  )

  tf_proto_library_py(name=name,
                   srcs=srcs,
                   protodeps = protodeps,
                    visibility = visibility,
                   )
