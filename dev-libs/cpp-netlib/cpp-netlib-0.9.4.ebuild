# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION="2.8"
inherit cmake-utils eutils

DESCRIPTION="C++ Network Library"
HOMEPAGE="http://cpp-netlib.org/0.9.4/index.html"
SRC_URI="https://github.com/downloads/cpp-netlib/cpp-netlib/${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl examples"

DEPEND=">=dev-libs/boost-1.45.0
	ssl? ( dev-libs/openssl )"
RDEPEND=""

RESTRICT="test mirror"

src_prepare() {
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_with ssl SSL) $(cmake-utils_use_with examples EXAMPLES)"
	cmake-utils_src_configure
}

