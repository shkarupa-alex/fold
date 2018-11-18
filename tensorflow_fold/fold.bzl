#load("@org_tensorflow//tensorflow/core:platform/default/build_config_root.bzl", "if_static")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "cc_proto_library")
load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library", "tf_proto_library_cc", "tf_proto_library_py")


def fold_proto_library(name, srcs, cc_deps=[], protodeps=[], visibility = [], cc_libs=[]):
  cc_proto_library(name=name + "_cc",
                   srcs=srcs,
                   deps=cc_deps + ["@protobuf_archive//:cc_wkt_protos"],
                   cc_libs=["@protobuf_archive//:protobuf"],
                   visibility = visibility,
                   )

  tf_proto_library_py(name=name,
                   srcs=srcs,
                   protodeps = protodeps,
                    visibility = visibility,
                   )
