# TensorFlow Fold external dependencies that can be loaded in WORKSPACE
# files.

load('@org_tensorflow//tensorflow:workspace.bzl', 'tf_workspace')
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# All TensorFlow Fold external dependencies.
# workspace_dir is the absolute path to the TensorFlow Fold repo. If linked
# as a submodule, it'll likely be '__workspace_dir__ + "/fold"'
def tf_fold_workspace():
  tf_workspace(tf_repo_name = "org_tensorflow")

  http_archive(
      name = "@com_google_absl",
      sha256 = "72996153de93642927284be81eb5002874aac6b364f8f87a18679c07d3daca19",
      strip_prefix = "abseil-cpp-6c7de165d1c82684359ccb630bb5f83263fa5ebc",
      urls = ["https://github.com/abseil/abseil-cpp/archive/6c7de165d1c82684359ccb630bb5f83263fa5ebc.tar.gz"],
  )

  # ===== gRPC dependencies =====
  native.bind(
    name = "libssl",
    actual = "@boringssl//:ssl",
  )

  native.bind(
      name = "zlib",
      actual = "@zlib_archive//:zlib",
  )

  native.bind(
      name = "gmock",
      actual = "@gmock_archive//:gmock",
  )
