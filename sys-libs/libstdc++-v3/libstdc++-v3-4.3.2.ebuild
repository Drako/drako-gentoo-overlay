# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PATCH_VER="1.6"
UCLIBC_VER="1.0"

ETYPE="gcc-compiler"

# Hardened gcc 4 stuff
PIE_VER="10.1.5"
PIE_GCC_VER="4.3.2"
SPECS_VER="0.9.4"
SPECS_GCC_VER="4.3.2"


# arch/libc configurations known to be stable or untested with {PIE,SSP,FORTIFY}-by-default
PIE_GLIBC_STABLE="x86 amd64 ~ppc ~ppc64 ~arm ~sparc"
PIE_UCLIBC_STABLE="x86 arm"
#SSP_STABLE="amd64 x86 ppc ppc64 ~arm ~sparc"
#SSP_UCLIBC_STABLE=""

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=no #${SPLIT_SPECS-true} hard disable until #106690 is fixed

inherit toolchain

DESCRIPTION="Compatibility package for running binaries linked against a pre gcc 4.3.2 libstdc++"
HOMEPAGE="http://gcc.gnu.org/libstdc++/"

LICENSE="GPL-3 LGPL-2.1 libgcc libstdc++"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-libs/zlib-1.1.4
	>=sys-devel/gcc-config-1.4
	virtual/libiconv
	>=dev-libs/gmp-4.2.1
	>=dev-libs/mpfr-2.3
	!build? (
		gcj? (
			gtk? (
				x11-libs/libXt
				x11-libs/libX11
				x11-libs/libXtst
				x11-proto/xproto
				x11-proto/xextproto
				>=x11-libs/gtk+-2.2
				x11-libs/pango
			)
			>=media-libs/libart_lgpl-2.1
			app-arch/zip
			app-arch/unzip
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"
DEPEND="${RDEPEND}
	test? ( sys-devel/autogen dev-util/dejagnu )
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	sys-devel/flex
	amd64? (
		>=sys-libs/glibc-2.7-r2
		multilib? (
			gcj? ( app-emulation/emul-linux-x86-xlibs )
		)
	)
	ppc? ( >=${CATEGORY}/binutils-2.17 )
	ppc64? ( >=${CATEGORY}/binutils-2.17 )
	>=sys-devel/binutils-2.15.94"
PDEPEND=">=sys-devel/gcc-config-1.4"
if [[ ${CATEGORY} != cross-* ]] ; then
	PDEPEND="${PDEPEND} elibc_glibc? ( >=sys-libs/glibc-2.6 )"
fi

src_unpack() {
	gcc_src_unpack

	use vanilla && return 0

	sed -i 's/use_fixproto=yes/:/' gcc/config.gcc #PR33200

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	[[ ${CTARGET} == *-softfloat-* ]] && epatch "${FILESDIR}"/4.3.2/gcc-4.3.2-softfloat.patch

}

src_compile() {

	gcc_do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p "${WORKDIR}"/build
	pushd "${WORKDIR}"/build > /dev/null

	einfo "Configuring ${PN} ..."
	gcc_do_configure

	touch "${S}"/gcc/c-gperf.h

	info "Compiling ${PN} ..."
	gcc_do_make all-target-libstdc++-v3

	popd > /dev/null

}

src_install() {

	export GCC_INSTALL_TARGET="install-target-libstdc++-v3"
	gcc-library_src_install
}
