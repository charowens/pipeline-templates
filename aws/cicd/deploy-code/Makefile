.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS = -euc

.SILENT:

UNTAR = tar -xf
TAR = tar -zcvf

TFVERSION = $$(cat ./.tfversion)
TFENV = tfenv

setTFVersion:
	${TFENV} use ${TFVERSION}

fetch-tar:
	./scripts/fetch_tar.sh

fetch-config:
	./scripts/fetch_metaschema.sh

build: 
	ls -a
	
plan: ls -a

deploy: ls -a


