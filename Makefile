DEBIAN_VERSION=13.3
DEBIAN_VER_SHA=17e1b73fa4f3383f5fe8d3423697f31f70d5c0acfbad77ce471ce75cda5d2b66
CHANGE_COUNTER=1
IMAGE_TAG=$(DEBIAN_VERSION)-$(CHANGE_COUNTER)
IMAGE_NAME=registry.cloudogu.com/official/base-debian
IMAGE_NAME_PRERELEASE=registry.cloudogu.com/prerelease_official/base-debian
DOGUCTL_VERSION=0.14.0
DOGUCTL_VER_SHA=1f1a17f87a6afb7a3eb886f9e3a07da7ac7b1503e7ae232d496d01b417e07df1
MAKEFILES_VERSION=10.5.0

default: build

include build/make/variables.mk
include build/make/self-update.mk
include build/make/clean.mk
include build/make/bats.mk

.PHONY: info
info:
	@echo "version information ..."
	@echo "Image (release)   : $(IMAGE_NAME):$(IMAGE_TAG)"
	@echo "Image (prerelease): $(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"

.PHONY: build
build:
	docker build \
	--build-arg "DEBIAN_VERSION=$(DEBIAN_VERSION)" \
	--build-arg "DEBIAN_VER_SHA=$(DEBIAN_VER_SHA)" \
	-t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: deploy
deploy: build
	@echo "Publishing image $(IMAGE_NAME):$(IMAGE_TAG)"
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: deploy-prerelease
deploy-prerelease: build
	@echo "Publishing image $(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"
	docker tag "$(IMAGE_NAME):$(IMAGE_TAG)" "$(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"
	docker rmi "$(IMAGE_NAME):$(IMAGE_TAG)"
	docker push "$(IMAGE_NAME_PRERELEASE):$(IMAGE_TAG)"

.PHONY: shell
shell: build
	docker run --rm -ti "$(IMAGE_NAME):$(IMAGE_TAG)" bash || 0
