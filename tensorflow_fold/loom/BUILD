# Loom enables TensorFlow to be easily and efficiently used to train
# networks whose shape differs on a per training example basis.  This allows
# TensorFlow to handle architectures including Tree RNNs, high dimensional
# sparse variants of GridLSTM and arbitrary architectures containing multiple
# LSTMs of example-dependant depth.  Loom is implemented as a library on
# top of TensorFlow.
licenses(["notice"])  # Apache 2.0
package(default_visibility = ["//tensorflow_fold:__subpackages__"])

load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library")
load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_py_wrap_cc", "tf_cc_test", "tf_cc_binary")


tf_proto_library(
    name = "loom_proto",
    srcs = ["loom.proto"],
    protodeps = [
        "@org_tensorflow//tensorflow/core:protos_all",
    ]
)

cc_library(
    name = "platform",
    hdrs = ["platform.h"],
    deps = [
        "@org_tensorflow//tensorflow/core:framework_headers_lib",
    ],
)

cc_library(
    name = "weaver",
    srcs = ["weaver.cc"],
    hdrs = ["weaver.h"],
    deps = [
        ":loom_proto_cc_headers_only",
        ":platform",
        "@org_tensorflow//third_party/eigen3",
    ],
)

tf_cc_test(
    name = "weaver_test",
    srcs = ["weaver_test.cc"],
    deps = [
        ":weaver",
        ":loom_proto_cc",
        "//tensorflow_fold/util:test_main",
    ],
)

tf_py_wrap_cc(
    name = "pywraptf_weaver",
    srcs = ["python/weaver.i"],
    deps = [
        ":weaver",
        ":loom_proto_cc",
        "@local_config_python//:python_headers",
    ],
)

cc_library(
    name = "weaver_op_base",
    srcs = ["weaver_op_base.cc"],
    hdrs = ["weaver_op_base.h"],
    deps = [
        ":weaver",
    ],
)

py_library(
    name = "weaver_op_base_py",
    srcs = ["weaver_op_base.py"],
    deps = [
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

#  The following two BUILD rules are an example of how you would use
#  weaver_op_base to define an op.
tf_cc_binary(
    name="_deserializing_weaver_op.so",
    srcs = ["deserializing_weaver_op.cc"],
    deps = [
        ":weaver",
        ":weaver_op_base",
    ],
    linkshared = 1,
)

py_library(
    name="deserializing_weaver_op",
    srcs = ["deserializing_weaver_op.py"],
    data = [
        ":_deserializing_weaver_op.so",
    ],
    deps = [
        ":weaver_op_base_py",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ]
)

py_library(
    name = "loom",
    srcs = ["loom.py"],
    deps = [
        ":loom_proto_py",
        ":pywraptf_weaver",
        ":deserializing_weaver_op",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_test(
    name = "loom_test",
    srcs = ["loom_test.py"],
    deps = [
        ":loom",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)
