DEBIAN_VERSION=13.0
DEBIAN_VER_SHA=c85a2732e97694ea77237c61304b3bb410e0e961dd6ee945997a06c788c545bb
CHANGE_COUNTER=1
IMAGE_TAG=$(ALPINE_VERSION)-$(CHANGE_COUNTER)
IMAGE_NAME=registry.cloudogu.com/official/base-debian
IMAGE_NAME_PRERELEASE=registry.cloudogu.com/prerelease_official/base-debian
DOGUCTL_VERSION=0.13.3
DOGUCTL_VER_SHA=612ca0c4890984401206c148106e4ced23c90924dd2ad979b2cbcc8b0a50e395
MAKEFILES_VERSION=10.2.0

default: build


include build/make/variables.mk
include build/make/self-update.mk
include build/make/clean.mk
include build/make/bats.mk


.PHONY: info
info:
	@echo "version informations ..."
	@echo "Version       : $(VERSION)"
	@echo "Image Name    : $(IMAGE_NAME)"
	@echo "Image Tag     : $(IMAGE_TAG)"
	@echo "Image         : $(IMAGE_NAME):$(DEBIAN_VERSION)-$(CHANGE_COUNTER)"

.PHONY: build
build:
	@echo "Verifying doguctl version..."
	@docker build --target doguctlbinaryverifier -t "$(IMAGE_NAME):you-can-safely-delete-this" .
	@docker rmi "$(IMAGE_NAME):you-can-safely-delete-this"
	@echo "Building production image..."
	@docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: deploy
deploy: build
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: shell
shell: build
	docker run --rm -ti "$(IMAGE_NAME):$(IMAGE_TAG)" bash || 0
