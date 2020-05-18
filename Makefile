BUILD_TAG ?= $$(git describe --always)
AWS_DEFAULT_REGION ?= us-east-1
AWS_ACCOUNT_ID ?= 687531305034
ECR_BASE=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

PROJECT=example
SERVICE=hello-world
ENVIRONMENT ?= prod

export

check-env :

	@if [ -z $(ENVIRONMENT) ]; then \
		echo "ENVIRONMENT must be set; export ENVIRONMENT=<env>"; exit 10; \
	fi

docker-build : check-env
	docker-compose build --pull

docker-up :
	docker-compose up -d

docker-down :
	docker-compose down

docker-push : docker-build
	docker-compose push

helm-template : check-env
	helm template $(SERVICE) helm/service \
		--namespace $(PROJECT) \
		--set image=$(ECR_BASE)/$(PROJECT)/$(SERVICE):$(BUILD_TAG) \
		--set environment=$(ENVIRONMENT) \
		--debug

helm-deploy : check-env
	-kubectl create namespace $(PROJECT)
	helm upgrade -i $(SERVICE) helm/$(SERVICE) \
		--namespace $(PROJECT) \
		--set image=$(ECR_BASE)/$(PROJECT)/$(SERVICE):$(BUILD_TAG) \
		--set environment=$(ENVIRONMENT)

helm-delete :
	helm del --purge $(SERVICE)
