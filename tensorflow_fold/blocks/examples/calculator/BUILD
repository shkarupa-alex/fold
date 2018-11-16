# Calculator example for TensorFlow Fold.

licenses(["notice"])  # Apache 2.0

py_library(
    name = "model",
    srcs = ["model.py"],
    deps = [
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/public:blocks",
    ],
)

py_binary(
    name = "train",
    srcs = ["train.py"],
    data = [
        "//tensorflow_fold/loom/calculator_example:calculator_proto_file",
    ],
    deps = [
        ":model",
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/loom/calculator_example:calculator_proto_py",
        "//tensorflow_fold/public:blocks",
        "//tensorflow_fold/util:proto",
    ],
)
