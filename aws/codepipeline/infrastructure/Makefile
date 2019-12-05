SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: default plan clean destroy setTFVersion

TF = terraform
JSONNET = jsonnet
RM = rm -rf
TFVERSION = $$(cat ./.tfversion)
TFENV = tfenv


default:
	echo "no default target"

setTFVersion:
	${TFENV} use ${TFVERSION}

plan: setTFVersion
	export AWS_PROFILE ${AWS_PROFILE}
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} plan

deploy: setTFVersion
	export AWS_PROFILE ${AWS_PROFILE}
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} apply --auto-approve --input=false
	${TF} output -json > output.json

destroy: setTFVersion
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} destroy --auto-approve --input=false

clean:
	${RM} $$(cat ./.gitignore)

create-ecr:
	scripts ./set-up-ecr.sh

