#!/usr/bin/env bash

# you must specify a output dir, and that dir should not exist.

if [ $# -ne 1 ]; then
    echo "Usage: $0 EXPORT_DIR"
    exit 1
else
    EXPORT_DIR=$1
    if [ -e "${EXPORT_DIR}" ]; then
        echo "export dir already exists!"
        exit 1
    fi
    # create the dir.
    mkdir -p "${EXPORT_DIR}"  # I'm strongly against having space in the path, although I guess it should work.
fi

# copy the specific git repo into that folder.
echo "copy git repo".
CURRENT_DIR=$(pwd)
# go to root of the repo, from http://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command.
ROOT_DIR=$(git rev-parse --show-toplevel)
cd "${ROOT_DIR}"
git archive --format=tar.gz 2390d26a94171d60185614e3d52dc5885d71de58 > /tmp/repo.tar.gz
# I put it first to tmp to solve the case where EXPORT_DIR is relative.
cd "${CURRENT_DIR}"
mv /tmp/repo.tar.gz "${EXPORT_DIR}/repo.tar.gz"

echo "copy Dockerfile and build script"
cp Dockerfile build_script.sh "${EXPORT_DIR}"
echo "copy playbook and related scripts"
cp playbook_vr2014.yml vr2014_figure_script_R_install_packages.R "${EXPORT_DIR}"

echo "copy matlab files."
# copy MATLAB 2014a files. I assume that you are in the same directory as this shell file.
mkdir "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/R2014a_UNIX_original.tar.gz "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/activate_R2014a.ini "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/install_R2014a.jar "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/installer_input_R2014a.txt "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/license_standalone_R2014a.lic "${EXPORT_DIR}/files"
cp "${ROOT_DIR}"/ansible/roles/matlab/files/libmwservices_R2014a.so "${EXPORT_DIR}/files"

# done.
echo "done."

