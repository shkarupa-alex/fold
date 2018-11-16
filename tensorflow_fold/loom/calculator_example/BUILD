# Tree RNN smoke test (learn a calculator.)
licenses(["notice"])  # Apache 2.0
package(default_visibility = ["//tensorflow_fold:__subpackages__"])

load("@org_tensorflow//tensorflow/core:platform/default/build_config.bzl", "tf_proto_library")

tf_proto_library(
    name = "calculator_proto",
    srcs = ["calculator.proto"],
    visibility = ["//tensorflow_fold:__subpackages__"],
)

filegroup(
    name = "calculator_proto_file",
    srcs = ["calculator.proto"],
)

py_library(
    name = "calculator",
    srcs = ["calculator.py"],
    deps = [
        ":calculator_proto_py",
    ],
)

py_test(
    name = "calculator_test",
    srcs = ["calculator_test.py"],
    deps = [
        ":calculator",
        ":calculator_proto_py",
        "@protobuf_archive//:protobuf_python",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_binary(
    name = "make_dataset",
    srcs = ["make_dataset.py"],
    deps = [
        ":calculator",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_library(
    name = "model",
    srcs = ["model.py"],
    deps = [
        ":calculator",
        ":calculator_proto_py",
        # numpy",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/public:loom",
    ],
)

py_test(
    name = "model_test",
    srcs = ["model_test.py"],
    deps = [
        ":calculator",
        ":model",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_library(
    name = "helpers",
    srcs = ["helpers.py"],
    deps = [
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_binary(
    name = "train",
    srcs = ["train.py"],
    deps = [
        ":calculator_proto_py",
        ":helpers",
        ":model",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_binary(
    name = "eval",
    srcs = ["eval.py"],
    deps = [
        ":calculator_proto_py",
        ":helpers",
        ":model",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)
