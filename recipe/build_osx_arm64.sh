export VERBOSE=1

echo "***************************************"
echo "***************************************"
echo "***************************************"
echo "CMAKE_ARGS=${CMAKE_ARGS}"
echo "PYTHON=${PYTHON}"
echo "PREFIX=${PREFIX}"
echo "BUILD_PREFIX=${BUILD_PREFIX}"
echo "CONDA_PREFIX=${CONDA_PREFIX}"
echo "CFLAGS=${CFLAGS}"
echo "CXXFLAGS=${CXXFLAGS}"

export CMAKE_PREFIX_PATH=${PREFIX}

# Filter CMAKE_PREFIX_PATH out of CMAKE_ARGS because scikit-build needs to set it
export SKBUILD_CONFIGURE_OPTIONS=$(echo $CMAKE_ARGS | sed -e 's/\-DCMAKE_INSTALL_PREFIX\=[^ ]* //g')
# Explicitly set the numpy include directory.
# export SKBUILD_CONFIGURE_OPTIONS="${SKBUILD_CONFIGURE_OPTIONS} -DNumPy_INCLUDE_DIR=$SP_DIR/numpy/core/include"

# echo "SKBUILD_CONFIGURE_OPTIONS=${SKBUILD_CONFIGURE_OPTIONS}"
# echo "numpy include=${SP_DIR/numpy/core/include}"

# ls -lR $PREFIX/lib

# work around a bug in conda-forge where the installed cython gets an invalid #! line: "#!$BUILD_PREFIX/bin/python"
# BUILD_PREFIX appears to be first on the path, so use /usr/bin/env python
echo "### Adding fixed shebang to cython"
echo '#!/usr/bin/env python' > cython.tmp
cat $BUILD_PREFIX/bin/cython >> cython.tmp
mv cython.tmp $BUILD_PREFIX/bin/cython
chmod ugo+rwx $BUILD_PREFIX/bin/cython

echo "### Performing installation"
$PYTHON -m pip install . --ignore-installed --no-cache-dir -vv --no-use-pep517 --no-build-isolation
