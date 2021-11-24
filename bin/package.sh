#!/bin/bash

BIN_DIR=`dirname $0`
PROJECT_ROOT_DIR=${BIN_DIR}/..

# sandbox's target dir
SANDBOX_TARGET_DIR=${PROJECT_ROOT_DIR}/dist/sandbox

rm -rf ${SANDBOX_TARGET_DIR}

# exit shell with err_code
# $1 : err_code
# $2 : err_msg
exit_on_err()
{
    [[ ! -z "${2}" ]] && echo "${2}" 1>&2
    exit ${1}
}

# reset the target dir
mkdir -p ${SANDBOX_TARGET_DIR}/bin
mkdir -p ${SANDBOX_TARGET_DIR}/lib
mkdir -p ${SANDBOX_TARGET_DIR}/module
mkdir -p ${SANDBOX_TARGET_DIR}/cfg
mkdir -p ${SANDBOX_TARGET_DIR}/provider
mkdir -p ${SANDBOX_TARGET_DIR}/sandbox-module

# copy bin to TARGET_DIR
cp ${BIN_DIR}/cfg/sandbox.sh ${SANDBOX_TARGET_DIR}/bin/sandbox.sh

# copy cfg to TARGET_DIR
cp ${BIN_DIR}/cfg/sandbox-logback.xml ${SANDBOX_TARGET_DIR}/cfg/sandbox-logback.xml
cp ${BIN_DIR}/cfg/sandbox.properties ${SANDBOX_TARGET_DIR}/cfg/sandbox.properties

# sandbox's version
SANDBOX_VERSION=$(cat ${PROJECT_ROOT_DIR}/sandbox-hook/sandbox-core/target/classes/com/alibaba/jvm/sandbox/version)
echo "${SANDBOX_VERSION}" > ${SANDBOX_TARGET_DIR}/cfg/version

# copy lib to TARGET_DIR
cp ${PROJECT_ROOT_DIR}/sandbox-hook/sandbox-core/target/sandbox-core-*-jar-with-dependencies.jar ${SANDBOX_TARGET_DIR}/lib/sandbox-core.jar
cp ${PROJECT_ROOT_DIR}/sandbox-hook/sandbox-agent/target/sandbox-agent-*-jar-with-dependencies.jar ${SANDBOX_TARGET_DIR}/lib/sandbox-agent.jar
cp ${PROJECT_ROOT_DIR}/sandbox-hook/sandbox-spy/target/sandbox-spy-*-jar-with-dependencies.jar ${SANDBOX_TARGET_DIR}/lib/sandbox-spy.jar

# copy module to TARGET_DIR
cp ${PROJECT_ROOT_DIR}/sandbox-module/sandbox-module-mgr/target/sandbox-module-mgr-*-jar-with-dependencies.jar ${SANDBOX_TARGET_DIR}/module/sandbox-module-mgr.jar

# copy provider to TARGET_DIR
cp ${PROJECT_ROOT_DIR}/sandbox-infra/sandbox-provider-mgr/target/sandbox-provider-mgr-*-jar-with-dependencies.jar ${SANDBOX_TARGET_DIR}/provider/sandbox-provider-mgr.jar

# make it execute able
chmod +x ${SANDBOX_TARGET_DIR}/bin/*.sh

