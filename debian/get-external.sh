#!/bin/sh

# Only fetch jsoncpp. We'll depend on packaged versions of glslang and
# spirv-tools instead of fetching them.

JSONCPP_REVISION=$(cat "external_revisions/jsoncpp_revision")
JSONCPP_URL="https://github.com/open-source-parsers/jsoncpp"
JSONCPP_DIR="external/jsoncpp"
JSONCPP_TARBALL="jsoncpp.tar.gz"

wget ${JSONCPP_URL}/archive/${JSONCPP_REVISION}.tar.gz -O ${JSONCPP_TARBALL}
mkdir -p ${JSONCPP_DIR}
tar xf ${JSONCPP_TARBALL} -C ${JSONCPP_DIR} --strip 1
cd ${JSONCPP_DIR}
python amalgamate.py

rm ${JSONCPP_TARBALL}

echo "Remember to run 'git add -f external/' and check that it looks sane"
