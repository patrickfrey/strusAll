Ubuntu 16.04 on x86_64, i686
----------------------------

# Build system
Cmake with gcc or clang. Here in this description we build with
gcc >= 4.9 (has C++11 support).

# Prerequisites
Install packages with 'apt-get'/aptitude.

## CMake flags
	-DWITH_PHP=YES
	to enable build with Php 7 language bindings.
	-DWITH_PYTHON=YES
	to enable build with Python 3 language bindings.
	-DWITH_STRUS_VECTOR=YES
	to build with a module for vector search (e.g. word2vec).
	-DWITH_STRUS_PATTERN=YES
	to build with a module for fast pattern matching based on hyperscan.

The prerequisites are listen in 5 sections, a common section (first) and for
each of these flags toggled to YES another section.

## Required packages (always)
	boost-all >= 1.57
	snappy-dev leveldb-dev libuv-dev

## Required packages with -DWITH_STRUS_PATTERN=YES
	ragel libtre-dev boost-all >= 1.57 hyperscan >= 5.1

### Install hyperscan from sources with -DWITH_STRUS_PATTERN=YES
	git clone https://github.com/intel/hyperscan.git
	cd hyperscan
	git checkout tags/v5.1.1
	mkdir build
	cd build
	cmake ..
	make
	make install

## Required packages with -DWITH_STRUS_VECTOR=YES
	atlas-dev lapack-dev blas-dev libarmadillo-dev

## Required packages with -DWITH_PYTHON=YES
	python3-dev

## Required packages with -DWITH_PHP=YES
	php7.0-dev zlib1g-dev libxml2-dev

## Required packages with -DWITH_STRUS_WEBSERVICE=YES
	libcurl4-openssl-dev zlib1g-dev libpcre3-dev cppcms >= 1.2

### Install cppcms with -DSTRUS_WITH_WEBSERVICE=YES
	wget https://sourceforge.net/projects/cppcms/files/cppcms/1.2.1/cppcms-1.2.1.tar.bz2
	bzip2 -d cppcms-1.2.1.tar.bz2
	tar -xvf cppcms-1.2.1.tar
	cd cppcms-1.2.1
	cmake -DCMAKE_CXX_FLAGS="-Wno-deprecated -Wno-unused-local-typedefs" .
	make
	make install

# Fetch sources
	git clone https://github.com/patrickfrey/strusAll
	cd strusAll
	git submodule update --init --recursive
	git submodule foreach --recursive git checkout master
	git submodule foreach --recursive git pull

# Configure with GNU C/C++ compiler
	With Lua,Php7 and Python3 bindings and strusVector and strusPattern:
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DWITH_PYTHON=YES \
		-DWITH_PHP=YES \
		-DWITH_STRUS_VECTOR=YES \
		-DWITH_STRUS_PATTERN=YES \
		-DLIB_INSTALL_DIR=lib .

# Configure with Clang C/C++ compiler
	Minimal build, only Lua bindings without Vector and Pattern and
	a reasonable default for library installation directory:

	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++" .

# Build
	make

# Run tests
	make test

# Install
	make install

