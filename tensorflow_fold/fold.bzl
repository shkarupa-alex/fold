# -*- Python -*-

load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "cc_proto_library")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "py_proto_library")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library", "tf_proto_library_cc", "tf_proto_library_py")

load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_cc_binary", "tf_cc_test", "tf_py_wrap_cc")


fold_cc_binary = tf_cc_binary
fold_cc_library = native.cc_library
fold_cc_test = tf_cc_test
fold_py_binary = native.py_binary
fold_py_library = native.py_library
fold_py_test = native.py_test
fold_py_wrap_cc = tf_py_wrap_cc


def fold_py_extension(name, srcs=[], outs=[], deps=[]):
  fold_cc_library(name=name + "_cc", srcs=srcs, deps=deps)
  for out in outs:
    fold_cc_binary(name=outs[0], srcs=[], linkshared=1, deps=[":" + name + "_cc"])


def fold_proto_library(cc_name, py_name, srcs, cc_deps=[], py_deps=[]):
  cc_proto_library(name=cc_name,
                   srcs=srcs,
                   deps=cc_deps,
                   cc_libs=["@protobuf_archive//:protobuf"],
                   )
  py_proto_library(name=py_name,
                   srcs=srcs,
                   deps=["@protobuf_archive//:protobuf_python"] + py_deps,
                   )


def fold_tf_op_py(name, srcs, cc_deps=[], py_deps=[]):
  so_name = "_" + name + ".so"
  fold_cc_binary(name=so_name, srcs=[], linkshared=1, deps=cc_deps)
  fold_py_library(name=name, srcs=srcs, data=[so_name], deps=py_deps)

