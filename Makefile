DEBIAN_VERSION="12.7"
CHANGE_COUNTER="2"
IMAGE_TAG="$(DEBIAN_VERSION)-$(CHANGE_COUNTER)"
IMAGE_NAME="registry.cloudogu.com/official/base-debian"
MAKEFILES_VERSION=9.0.5

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
	docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: deploy
deploy: build
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"

.PHONY: shell
shell: build
	docker run --rm -ti "$(IMAGE_NAME):$(IMAGE_TAG)" bash || 0
