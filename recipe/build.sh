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
CMAKE_ARGS_FILTERED=$(echo $CMAKE_ARGS | sed -e 's/\-DCMAKE_INSTALL_PREFIX\=[^ ]* //g')

# work around a bug in conda-forge where the installed cython gets an invalid #! line: "#!$BUILD_PREFIX/bin/python"
# BUILD_PREFIX appears to be first on the path, so use /usr/bin/env python
echo "### cat $BUILD_PREFIX/bin/cython"
cat $BUILD_PREFIX/bin/cython

echo "### Running sed
sed 's/\$BUILD_PREFIX.*/\/usr\/bin\/env python/g' $BUILD_PREFIX/bin/cython
sed 's/\$BUILD_PREFIX.*/\/usr\/bin\/env python/g' $BUILD_PREFIX/bin/cython > cython.tmp
mv cython.tmp $BUILD_PREFIX/cython
chmod ugo+rwx $BUILD_PREFIX/cython

echo "### cat $BUILD_PREFIX/bin/cython"
cat $BUILD_PREFIX/bin/cython

echo "### cython --version"
$BUILD_PREFIX/bin/cython --version

echo "### Performing installation"
${PYTHON} setup.py install --root=/ --single-version-externally-managed -- ${CMAKE_ARGS_FILTERED}
