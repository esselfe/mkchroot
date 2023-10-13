#!/bin/bash

mkdir chroot
cd chroot

ln -sfv lib lib64
cp -rpdv /lib lib | sed '/\/lib\/modules/d;/\/lib\/firmware/d'
cp -rpdv /bin bin
mkdir -pv usr/lib
ln -sfv lib usr/lib64

rm -rf lib/firmware
rm -rf lib/modules/*
cp -pdv /usr/lib/libc.* usr/lib
cp -pdv /usr/lib/libm.* usr/lib
cp -v /usr/lib/libcap.so.2 usr/lib
cp -v /usr/lib/libmpfr.so.6 usr/lib
cp -v /usr/lib/libgmp.so.10 usr/lib
ln -sv ../../lib/libncurses.so.6 usr/lib/libncurses.so.6

cp -fv /usr/bin/ls bin
rm -fv bin/{echo,env,grep,gawk,ln,pwd}
cp -fv /usr/bin/{cat,cut,date,df,du,echo,env,grep,gawk,ln,pwd,tr,which} bin

mkdir -v etc
cp -v /etc/ld.so.conf etc
cp -pv /etc/inputrc etc
echo 'export PATH=/bin:/usr/bin' > etc/profile
echo 'export PS1="\t\u@\l:\w\\$ "' >> etc/profile
echo 'export LANG=en_US.UTF-8' >> etc/profile
echo 'alias ls="ls -A --color=auto"' >> etc/profile
echo 'alias qw="exit"' >> etc/profile

echo 'root:x:0:0:root:/root:/bin/bash' > etc/passwd
echo 'root:x:0:root' > etc/group
mkdir -v root

