#!/usr/bin/env bash
# Install CUDA 7.5 for Linux in home directory.
# check if the file exists.
cd ~
INSTALLER="${HOME}/cuda_7.5.18_linux.run"
TOOLKITPATH="${HOME}/cuda-7.5"
SAMPLEPATH="${HOME}/NVIDIA_CUDA-7.5_Samples"
if [ ! -f "${INSTALLER}" ]; then
    curl -k -L -o cuda_7.5.18_linux.run \
        http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run
fi

sh cuda_7.5.18_linux.run --silent --toolkit --samples --toolkitpath=${TOOLKITPATH} --samplespath=${SAMPLEPATH}

echo "CUDA 7.5 has been installed under ${TOOLKITPATH}, sample at ${SAMPLEPATH}"
echo "create a symlink at ${HOME}/cuda for convenience, as we usually only need one single CUDA toolkit"


# check <https://devblogs.nvidia.com/parallelforall/cuda-pro-tip-understand-fat-binaries-jit-caching/>
echo "for performance (on cluster), add 'export CUDA_CACHE_PATH=\"/tmp/.nv_\${USER}/ComputeCache\"' under appropriate file, such as .bashrc or .profile"
