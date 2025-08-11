DEBIAN_VERSION="12.9"
CHANGE_COUNTER="1"
IMAGE_TAG="$(DEBIAN_VERSION)-$(CHANGE_COUNTER)"
IMAGE_NAME="registry.cloudogu.com/official/base-debian"
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
