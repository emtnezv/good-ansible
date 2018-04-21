#!/bin/bash -el

set -o pipefail

# BASE_DIR is the root path, no more relative path issues
BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source ${BASE_DIR}/config/lab_vars
cd ${BASE_DIR}

INVENTORY="${BASE_DIR}/inventory/myinventory.file"
ANSIBLE_CFG="${BASE_DIR}/config/ansible.cfg"
SECRET="${BASE_DIR}/config/secret"

PASSWD="${2}"
echo ${PASSWD} > ${SECRET}

export ANSIBLE_CONFIG="${ANSIBLE_CFG}"
#export ANSIBLE_VAULT_PASSWORD_FILE="${SECRET}"

INPUT="${1}"

case ${INPUT} in
    provision-all)
        ansible-playbook -i ${INVENTORY} --vault-password-file=${SECRET} --extra-vars "GUID=${GUID}" playbooks/provision.yml -vv
        > ${SECRET}
        ;;
    clear-all)
        ansible-playbook -i ${INVENTORY} playbooks/cleanup.yml -vv
        ;;
    haproxy)
        ansible-playbook -i ${INVENTORY} --vault-password-file=${SECRET} --tags 'haproxy' playbooks/provision.yml -vv
        > ${SECRET}
        ;;
    tomcat)
        ansible-playbook -i ${INVENTORY} --vault-password-file=${SECRET} --tags 'tomcat' playbooks/provision.yml -vv
        > ${SECRET}
        ;;
    database)
        ansible-playbook -i ${INVENTORY} --vault-password-file=${SECRET} --tags 'database' playbooks/provision.yml -vv
        > ${SECRET}
        ;;
    tests)
        ansible-playbook -i ${INVENTORY} --vault-password-file=${SECRET} --extra-vars "GUID=${GUID}" --tags 'tests' playbooks/provision.yml -vv
        > ${SECRET}
        ;;
    help)
        help
        ;;
    *)
        help
        ;;
esac
