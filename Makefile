mkfile_path := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
mkfile_dir := $(shell cd $(shell dirname $(mkfile_path)); pwd)
current_dir := $(notdir $(mkfile_dir))
build_number := $(shell date +%Y%m%d%H%M)
host_name := $(shell hostname)

IMAGE := dockerdata
IMAGE_ID := android_$(shell whoami)
IMAGE_TAG := v1
SOURCES := $(mkfile_dir)

HOMEDIR:=/home/docker/
WORKDIR:=$(HOMEDIR)/android
SCRIPTS_DIR:=$(WORKDIR)/build_scripts

DOCKER := docker
DOCKER += run --rm -it
DOCKER += -v $(SOURCES):$(WORKDIR)

# For local usage
###################################
# OUT=$(WORKDIR)/device/device/out
# MOUNT_OUT=$(VOLUME_DIR)/device/out
# DOCKER += -v $(OUT):$(MOUNT_OUT)

###################################

DOCKER += -v ${HOME}/.gitconfig:$(HOMEDIR)/.gitconfig:ro
DOCKER += --net=host
DOCKER += --security-opt apparmor=unconfined --security-opt seccomp=unconfined --security-opt systempaths=unconfined
DOCKER += $(IMAGE_ID):$(IMAGE_TAG)

help:
	@echo "make help - print this message"
	@echo "make docker - build a docker image"
	@echo "make build_device - build android images for device"
	@echo "make clean - interactively remove output directories"
	@echo "make clean_all - remove output directories"
	@echo "make sh - run shell in the docker container"

build_device: docker _build_device_userdebug

build_device_userdebug:
	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" lunch_make_build device userdebug || :;

clean:
	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" clean || :;

clean_all:
	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" clean_all || :;

# open docker shell (for debug and etc)
sh:
	$(DOCKER) /bin/bash || :;

# generate(regenerate) docker image
docker:
	docker build -t $(IMAGE_ID):$(IMAGE_TAG) --build-arg USER_ID=$(shell id -u) $(mkfile_dir)/$(IMAGE)

%: help

# Expamples
# build_example_device_eng:
# 	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" lunch_make_build example eng || :;

# build_example_custom:
# 	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" custom_build example example.sh || :;
