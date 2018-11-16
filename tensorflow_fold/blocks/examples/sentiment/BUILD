# Experiments applying TensorFlow Fold to Stanford Sentiment Treebank data
# <nlp.stanford.edu/sentiment/treebank.html>

licenses(["notice"])  # Apache 2.0

py_library(
    name = "sentiment",
    srcs = ["sentiment.py"],
    deps = [
        # nltk
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/public:blocks",
    ],
)

py_binary(
    name = "train",
    srcs = ["train.py"],
    deps = [
        ":sentiment",
        "@org_tensorflow//tensorflow:tensorflow_py",
        "//tensorflow_fold/public:blocks",
    ],
)

py_binary(
    name = "eval",
    srcs = ["eval.py"],
    deps = [
        ":sentiment",
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)

py_binary(
    name = "filter_glove",
    srcs = ["filter_glove.py"],
    deps = [
        "@org_tensorflow//tensorflow:tensorflow_py",
    ],
)
