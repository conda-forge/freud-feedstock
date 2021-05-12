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

${PYTHON} setup.py install --root=$PREFIX --single-version-externally-managed -- ${CMAKE_ARGS_FILTERED}
