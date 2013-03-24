# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION="2.6"
inherit linux-mod

DESCRIPTION="Read BOFH excuses from /proc/excuse"
HOMEPAGE="https://github.com/Drako/bofh"

MY_P="bofh-${MY_PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="https://github.com/Drako/bofh/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="test mirror"

CONFIG_CHECK="PROC_FS"
MODULE_NAMES="bofh"

