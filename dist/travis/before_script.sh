#!/bin/sh

set -e

OS=$(uname -s)

case $OS in
	Linux)
		sudo apt-get update -qq
		sudo apt-get install -y \
			cmake \
			libleveldb-dev \
			libatlas-dev \
			liblapack-dev \
			libblas-dev \
			python3-dev \
			libtre-dev \
			ragel
		sudo add-apt-repository -y ppa:kojoley/boost
		sudo apt-get -q update
		sudo apt-get install libboost-atomic1.58-dev libboost-thread1.58-dev libboost-system1.58-dev libboost-filesystem1.58-dev libboost-regex1.58-dev
		;;

	Darwin)
		brew update
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

