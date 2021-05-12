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
${PYTHON} -m pip install . --ignore-installed --no-cache-dir -vv --install-option="-- ${CMAKE_ARGS}"

ls /Users/runner/miniforge3/conda-bld/freud_* -R
