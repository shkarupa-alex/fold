licenses(["notice"])  # Apache 2.0
package(default_visibility = ["//visibility:public"])

load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library")
load("@org_tensorflow//tensorflow:tensorflow.bzl", "tf_cc_binary")

tf_proto_library(
    name = "test_proto",
    srcs = ["test.proto"],
    visibility = ["//tensorflow_fold:__subpackages__"],
)

tf_proto_library(
    name = "test3_proto",
    srcs = ["test3.proto"],
)

filegroup(
    name = "test_proto_files",
    srcs = [
        "test.proto",
        "test3.proto",
    ],
)

cc_library(
    name = "test_main",
    testonly = 1,
    srcs = ["test_main.cc"],
    linkopts = ["-lm"],
    deps = [
        "@com_google_googletest//:gtest",
        "@org_tensorflow//tensorflow/core:framework_lite",
        "@org_tensorflow//tensorflow/core:testlib",
    ],
)

cc_library(
    name="proto_tools_cc",
    srcs=["proto_tools.cc"],
    deps = [
        "@org_tensorflow//tensorflow/core:framework_headers_lib",
        "@local_config_python//:python_headers",
        "@protobuf_archive//:protobuf",
    ],
)

tf_cc_binary(
    name = "proto_tools.so",
    srcs = [],
    deps=[":proto_tools_cc"],
    linkshared = 1,
)

py_library(
    name = "proto",
    srcs = [],
    data = [":proto_tools.so"],
)

py_test(
    name = "proto_test",
    srcs = ["proto_test.py"],
    data = [
        "test.proto",
        "test3.proto",
    ],
    deps = [
        ":proto",
        ":test_proto_py",
        ":test3_proto_py",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_library(
    name = "cpp_test_proto_lib",
    srcs = [],
    deps = [
        ":test_proto_py",
        ":test3_proto_py",
    ],
)

sh_binary(
    name = "build_pip_package",
    srcs = ["build_pip_package.sh"],
    data = [
        "//tensorflow_fold:headers",
        "//tensorflow_fold/public:blocks",
        "//tensorflow_fold/public:loom",
        "//tensorflow_fold/public:loom_cc",
    ],
)
