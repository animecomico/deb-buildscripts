#!/bin/bash
export NAME=bup
export VERSION=0.25rc1
export DEBVERSION=${VERSION}-1
#Download it
git clone git://github.com/bup/bup.git
(cd bup && git checkout bup-0.25-rc1 && rm -rf .git)
tar xzvf ${NAME}_${VERSION}.orig.tar.gz
cd bup
rm -rf debian
mkdir -p debian
#Use the existing COPYING file
cp COPYING debian/copyright
#Create the changelog (no messages - dummy)
dch --create -v $DEBVERSION --package ${NAME} ""
#Create copyright file
cp COPYING debian/copyright
#Create control file
echo "Source: $NAME" > debian/control
echo "Maintainer: None <none@example.com>" >> debian/control
echo "Section: misc" >> debian/control
echo "Priority: optional" >> debian/control
echo "Standards-Version: 3.9.2" >> debian/control
echo "Build-Depends: debhelper (>= 8)" >> debian/control
#Main library package
echo "" >> debian/control
echo "Package: $NAME" >> debian/control
echo "Architecture: amd64" >> debian/control
echo "Depends: ${shlibs:Depends}, ${misc:Depends}, libzmq (>= 3.0)" >> debian/control
echo "Homepage: https://github.com/bup/bup" >> debian/control
echo "Description: BUP backup system" >> debian/control
#Rules files
echo '#!/usr/bin/make -f' > debian/rules
echo '%:' >> debian/rules
echo -e '\tdh $@' >> debian/rules
echo 'override_dh_auto_configure:' >> debian/rules
echo -e "\t./configure" >> debian/rules
echo 'override_dh_auto_build:' >> debian/rules
echo -e '\tmake' >> debian/rules
echo 'override_dh_auto_install:' >> debian/rules
echo -e "\tmkdir -p debian/$NAME/usr" >> debian/rules
echo -e "\tmake install PREFIX=debian/$NAME/usr" >> debian/rules
#Create some misc files
mkdir -p debian/source
echo "8" > debian/compat
echo "3.0 (quilt)" > debian/source/format
#Build it
debuild -us -uc
