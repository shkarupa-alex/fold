licenses(["notice"])  # Apache 2.0
package(default_visibility = ["//visibility:public"])

py_library(
    name = "loom",
    srcs = ["loom.py"],
    deps = [
        "//tensorflow_fold/loom",
    ],
)

cc_library(
    name = "loom_cc",
    hdrs = ["loom.h"],
    deps = [
        "//tensorflow_fold/loom:deserializing_weaver_op_cc",
        "//tensorflow_fold/loom:weaver",
        "//tensorflow_fold/loom:weaver_op_base",
    ],
)

py_library(
    name = "blocks",
    srcs = ["blocks.py"],
    deps = [
        "//tensorflow_fold/blocks",
        "//tensorflow_fold/blocks:plan",
        "//tensorflow_fold/blocks:result_types",
        "//tensorflow_fold/blocks:util",
    ],
)
