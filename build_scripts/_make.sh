#!/bin/bash -e

SCRIPT_NAME=${0##*/}
readonly SCRIPT_VERSION="0.1"

readonly ABSOLUTE_PATH_SCRIPT=`readlink -e "$0"`
readonly SCRIPT_DIR=`dirname ${ABSOLUTE_PATH_SCRIPT}`
readonly BASE_DIR=`dirname ${SCRIPT_DIR}`
readonly command=${1-lunch_make_build}
readonly DEVICE=${2-device}
readonly ANDROID_SRC_DIR="${BASE_DIR}/${DEVICE}"

custom_build(){
	echo ">>>>>>> Custom build ${DEVICE} <<<<<<<"
	readonly SCRIPT_NAME=${3-example.sh}
	mkdir -p "$ANDROID_SRC_DIR"
	pushd "$ANDROID_SRC_DIR"
	popd
	pushd ${BASE_DIR}
	bash ${SCRIPT_DIR}/${SCRIPT_NAME} ${DEVICE}
	popd
}

lunch_make_build(){
	echo ">>>>>>> lunch & make ${DEVICE} <<<<<<<"
	readonly BUILD_VARIANT=${3-userdebug}
	readonly LUNCH_NAME="${DEVICE}-${BUILD_VARIANT}"
	pushd "$ANDROID_SRC_DIR"
		ulimit -s 65536
		source build/envsetup.sh
		echo lunch ${LUNCH_NAME}
		lunch ${LUNCH_NAME}
		m
	popd
}

clean(){
	echo ">>>>>>> clean artefacts interactively <<<<<<<"
	for x in $(find -maxdepth 2 -name out)
	do
		while true
		do
			read -r -p "Delete ${x/\.\/} [Y/n] " input

			case $input in
				[yY][eE][sS]|[yY])
					rm -rf $x
					break
					;;
				[nN][oO]|[nN])
					break
					;;
				*)
					echo "Y[es]/N[o]"
					;;
			esac
		done
	done
}

clean_all(){
	echo ">>>>>>> clean artefacts <<<<<<<"
	for x in $(find -maxdepth 2 -name out)
	do
		echo "removed directory '${x/\.\/}'"
		rm -rf $x
	done
}

if [[ x"${command}" == x"lunch_make_build" ]]; then
	lunch_make_build
elif [[ x"${command}" == x"custom_build" ]]; then
	custom_build
elif [[ x"${command}" == x"clean" ]]; then
	clean
elif [[ x"${command}" == x"clean_all" ]]; then
	clean_all
else
	echo ">>>>>>> not supported  <<<<<<<"

fi
