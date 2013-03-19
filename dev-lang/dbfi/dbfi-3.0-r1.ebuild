# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils

DESCRIPTION="A brainfuck interpreter"
HOMEPAGE="https://github.com/Drako/dbfi"

SRC_URI="https://github.com/Drako/dbfi/archive/v${PV}-rc1.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-compiler -debug"

DEPEND=""
#DEPEND="compiler? ( >=dev-lang/tcc-0.9.26 )"
RDEPEND=""

RESTRICT="test mirror"

#src_configure() {
#	CMAKEARGS="$(cmake-utils_use_with compiler COMPILER)"
	#if use debug; then
	#	CMAKE_BUILD_TYPE="Debug"
	#else
#		CMAKE_BUILD_TYPE="Debug"
	#fi

#	cmake-utils_src_configure ${CMAKEARGS}
#}

