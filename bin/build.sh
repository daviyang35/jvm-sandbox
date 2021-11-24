#!/bin/bash

BIN_DIR=`dirname $0`
PROJECT_ROOT_DIR=${BIN_DIR}/..

# exit shell with err_code
# $1 : err_code
# $2 : err_msg
exit_on_err()
{
    [[ ! -z "${2}" ]] && echo "${2}" 1>&2
    exit ${1}
}

# maven package the sandbox
mvn clean cobertura:cobertura package -Dmaven.test.skip=false -f ${PROJECT_ROOT_DIR}/pom.xml || exit_on_err 1 "package sandbox failed."
