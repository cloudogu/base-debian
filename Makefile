DEBIAN_VERSION=12.14
DEBIAN_VER_SHA=30482e873082e906a4908c10529180aefb6f77620aea7404b909829fadc5d168
CHANGE_COUNTER=1
IMAGE_TAG=$(DEBIAN_VERSION)-$(CHANGE_COUNTER)
IMAGE_NAME=registry.cloudogu.com/official/base-debian
IMAGE_NAME_PRERELEASE=registry.cloudogu.com/prerelease_official/base-debian
DOGUCTL_VERSION=0.15.1
DOGUCTL_VER_SHA=5a3042dbf54341884347cdd99bb60e032c6d2ba8909799114e4fd5d6fc33fe93
# renovate: datasource=github-tags depName=cloudogu/makefiles extractVersion=^v(?<version>.*)$
MAKEFILES_VERSION=10.9.1

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
	--no-cache \
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
