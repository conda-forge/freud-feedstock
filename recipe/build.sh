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

echo "################ testing ########################"
which python

echo $BUILD_PREFIX

ls $BUILD_PREFIX

ls '$BUILD_PREFIX'

echo '#!\$BUILD_PREFIX/bin/python' > test.sh
echo 'print("Hello")' >> test.sh
chmod u+rwx test.sh
./test.sh

# Filter CMAKE_PREFIX_PATH out of CMAKE_ARGS because scikit-build needs to set it
CMAKE_ARGS_FILTERED=$(echo $CMAKE_ARGS | sed -e 's/\-DCMAKE_INSTALL_PREFIX\=[^ ]* //g')

# work around a bug in conda-forge where the installed cython gets an invalid #! line: "#!$BUILD_PREFIX/bin/python"
# echo "#######################################"
# echo '#!/bin/sh' > $BUILD_PREFIX/bin/cython

cat $BUILD_PREFIX/bin/cython
$BUILD_PREFIX/bin/cython --version

${PYTHON} setup.py install --root=/ --single-version-externally-managed -- ${CMAKE_ARGS_FILTERED}
