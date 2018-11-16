# Fizzbuzz example for TensorFlow Fold.

licenses(["notice"])  # Apache 2.0

py_binary(
    name = "fizzbuzz",
    srcs = ["fizzbuzz.py"],
    deps = [
        "@six_archive//:six",
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/public:blocks",
    ],
)
