# MNIST example for TensorFlow Fold.

licenses(["notice"])  # Apache 2.0

py_binary(
    name = "language_id",
    srcs = ["language_id.py"],
    deps = [
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/blocks/examples:plan",
        "//tensorflow_fold/public:blocks",
    ],
)
