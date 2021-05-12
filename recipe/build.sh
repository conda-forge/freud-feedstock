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
${PYTHON} -m pip install . --ignore-installed --no-cache-dir -vv --install-option="-- ${CMAKE_ARGS} -DNumPy_INCLUDE_DIR=${SP_DIR}/numpy/core/include -DCYTHON_EXECUTABLE=$BUILD_PREFIX/bin/cython -DPYTHON_EXECUTABLE=$BUILD_PREFIX/bin/python3"

ls -R /Users/runner/miniforge3/conda-bld/freud_*
