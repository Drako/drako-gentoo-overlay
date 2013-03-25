# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION="2.6"
inherit cmake-utils eutils versionator

DESCRIPTION="A brainfuck interpreter"
HOMEPAGE="https://github.com/Drako/dbfi"

MY_PV="$(replace_version_separator 2 '-')"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="https://github.com/Drako/dbfi/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="**"
IUSE="compiler"

DEPEND="compiler? ( >=dev-lang/tcc-0.9.26 )"
RDEPEND=""

RESTRICT="test mirror"

src_prepare() {
	cd "${S}/src"
	sed "s/@GIT_HASH@/v${MY_PV}/" <config.h.in >config.h.in
	sed 's/Hash:/Tag: /' <main.c >main.c
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with compiler COMPILER)"
	cmake-utils_src_configure
}

