function install_theano_tf {
    DIR_LOCAL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	if [ $# -ne 1 ]; then
		echo "give python version"
		exit 1
	fi
    # check python version
    if [ "$1" != "2.7" -a "$1" != "3.5" ]; then
        "only 2.7 and 3.5 are supported"
        exit 1
    fi
	conda install --yes -c conda-forge --no-update-dependencies protobuf>=3
    pip install nose-parameterized Theano==0.8.2
    # then let's install tensorflow.
    if [ "$1" == "2.7" ]; then
        pip install /data2/leelab/software/tensorflow/gpu/py27/tensorflow-0.11.0rc0-py2-none-any.whl
    elif [ "$1" == "3.5" ]; then
        pip install /data2/leelab/software/tensorflow/gpu/py35/tensorflow-0.11.0rc0-py3-none-any.whl
    fi
    # install cudnn v5
    ${DIR_LOCAL}/../../cuda/install_cudnn_v5.sh
    # post install for theano
    echo -e  "[cuda]\nroot = ${HOME}/cuda\n[global]\ndevice = gpu0\nfloatX = float32\nbase_compiledir = /tmp/.theano_${USER}"  >  "${HOME}/.theanorc"
}