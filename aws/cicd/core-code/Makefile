.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS = -euc

.SILENT:

.PHONY: all

COPY = mkdir -p $$(dirname $@) && cp $< $@

UNTAR = tar -xvf
TAR = tar -zcvf
TFVERSION = $$(cat ./.tfversion)
TFENV = tfenv

setTFVersion:
	${TFENV} use ${TFVERSION}

all: 

clean:

tag:
	./version.sh
deliver:
	./release.sh $$(cat version)