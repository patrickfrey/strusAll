#!/bin/sh

set -e

OS=$(uname -s)

case $OS in
	Linux)
		sudo apt-get update -qq
		sudo apt-get install -y \
			cmake \
			libboost-all-dev \
			libleveldb-dev \
			libatlas-dev \
			liblapack-dev \
			libblas-dev \
			python3-dev \
			libtre-dev \
			ragel
		;;

	Darwin)
		brew update
		brew tap homebrew/dupes
		brew tap homebrew/versions
		brew upgrade cmake
		brew upgrade boost
		brew install cmake gettext snappy leveldb python3 tre ragel || true
		# make sure cmake finds the brew version of gettext
		brew link --force gettext || true
		brew link leveldb || true
		brew link snappy || true
		;;

	*)
		echo "ERROR: unknown operating system '$OS'."
		;;
esac

