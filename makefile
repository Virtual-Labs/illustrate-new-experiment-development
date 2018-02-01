SHELL := /bin/bash
PWD=$(shell pwd)
SRC_DIR=${PWD}/src
VERSION_FILE_TEMPLATE=${PWD}/src/version.org.template
VERSION_FILE=${PWD}/src/version.org
CODE_DIR=build/code
DOC_DIR=build/docs
tag=$(shell git tag -l | tail -1)
export tag

all:  build

init: 
	./init.sh

write-version:
	rm -rf ${VERSION_FILE}
	cp ${VERSION_FILE_TEMPLATE} ${VERSION_FILE}
	echo ${tag} >> ${VERSION_FILE}


build: init write-version
	make -f tangle-make -k readtheorg=true all

clean:	
	make -f tangle-make clean

host:
	rm -rf /var/www/html/*
	rsync -a ${PWD}/${CODE_DIR}/runtime/ /var/www/html/

