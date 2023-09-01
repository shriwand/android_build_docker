# Build device images in a unified environment

## Usage

### Install docker
[Install docker](https://docs.docker.com/engine/install/).
Tested on docker server.
Docker desktop is also possible (most Likely).

### Setting up sources

  * Clone sources

``` sh
git clone # url

```

### Usage example

``` sh
make sh
cd android
. lunch device-userdebug
make
```

## Motivation

  * Build Android not only in ubuntu Linux without hacks.
  * Reprocessable environment.
  * Simplification.
  * Opportunity for building images for multiple devices easily.

## Help
``` sh
make
# or
make help
```

## Detailes of realisation

Use ubuntu xenial based docker container for providing environment.
The make utility starts building process.
And android build system works with full android source tree.

  * _dockerdata/Dockerfile_
  * _Makefile_
  * _buildscripts/make.sh_ - main building script which is executed by make utility.
  * _build_scripts/example.sh_ - example of custom build script.

## Adding build for new device

### Motivation

For building in one command, e.g.

``` sh
make build_device
```

### Typical launch & make build

  * Clone sources

``` sh
git clone #url
```
  
  * Add new target to _Makefile_:

``` sh
### Example of building
# lunch_make_build - standard way build
# example - name of the device. Name of submodule's dir must be the same.
# eng - user | userdebug | eng build (for launch)
build_example_device_eng:
 	$(DOCKER) /bin/bash -i "$(WORKDIR)/_make.sh" lunch_make_build example eng || :;
```
  * Add new target to dependencies of all in _Makefile_ (optionally):

``` sh
all: build_example_device_eng # ... rest of dependencies
```

### Custom way of building

  * Add device sources:

``` sh
git clone #url
```
  * Add build script to directory build_scripts. (See _build_scripts/example.sh_)
  * Add new target to _Makefile_:
``` sh
### Example of building
# custom_build - custom way build
# example - name of the device. Name of submodule's dir must be the same.
# example.sh - name of the script in build_scripts directory.
build_example_custom:
	$(DOCKER) /bin/bash -i "$(SCRIPTS_DIR)/_make.sh" custom_build example example.sh || :;
```
