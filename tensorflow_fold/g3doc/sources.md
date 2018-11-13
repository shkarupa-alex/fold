# Source Installation

Building Fold requires Bazel; get
it [here](https://bazel.build/versions/master/docs/install.html). The do:

```
pip install pip --upgrade
pip install wheel --upgrade
pip install numpy --upgrade
bazel build tensorflow_fold/...
```

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
./bazel-bin/tensorflow_fold/util/build_pip_package `pwd`/wheels
```

Now install the wheel. The precise names of the `.whl` file will
depend on your platform.

```
pip install wheels/*
```
