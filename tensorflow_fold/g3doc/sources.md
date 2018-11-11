# Source Installation

Building Fold requires Bazel; get
it [here](https://bazel.build/versions/master/docs/install.html). The do:

```
pip install pip --upgrade
pip install wheel --upgrade
pip install numpy --upgrade
bazel build tensorflow_fold/...
```

If your TensorFlow not built from source add --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" to build/test commands.
If build fails with GRPC linking failure on MacOS X, add --copt -DGRPC_BAZEL_BUILD to build/test commands.

Follow the
instructions
[here](https://www.tensorflow.org/get_started/os_setup#configure_the_installation) if
you need help with the `configure` script; Fold inherits its configuration
options, such as the location of Python and which optimization flags to use
during compilation, from TensorFlow.

### Running the tests (optional)

To run the unit tests, do:

```
pip install mock --upgrade
bazel test --config=opt tensorflow_fold/...
```

When using CUDA on GPU, tests must be run sequentially:
```
bazel test --config=opt --config=cuda --jobs=1 tensorflow_fold/...
```

There is also a smoke test that runs all of the included examples:

```
pip install nltk --upgrade
./tensorflow_fold/run_all_examples.sh --config=opt
```

### Building and installing pip wheels

Build a pip wheel for Fold like so:

```
bazel build --config=opt //tensorflow_fold/util:build_pip_package
./bazel-bin/tensorflow_fold/util/build_pip_package /tmp/fold_pkg
```

You also need to build a pip wheel for TensorFlow. Unfortuately this means we
need to rebuild all of TensorFlow, due to known Bazel limitations
([#1248](https://github.com/bazelbuild/bazel/issues/1248)). If you want skip
this step and reuse an existing TensorFlow wheel file, make sure that the
configuration and version are the same ones that Fold has to ensure consistency.

```
cd tensorflow
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
cd ..
```

Now install the wheels. The precise names of the `.whl` files will
depend on your platform.

```
pip install /tmp/fold_pkg/tensorflow_fold-0.0.1-cp27-cp27mu-linux_x86_64.whl
pip install /tmp/tensorflow_pkg/tensorflow-1.0.0rc0-cp27-cp27mu-linux_x86_64.whl
```
