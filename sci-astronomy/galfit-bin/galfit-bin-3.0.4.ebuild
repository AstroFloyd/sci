# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MYPN=galfit

inherit multilib

DESCRIPTION="Galaxy morphology fitting program"
HOMEPAGE="http://www.csua.berkeley.edu/~cyp/work/galfit/galfit.html"
CURI="http://www.csua.berkeley.edu/~cyp/work/${MYPN}"
SRC_URI="amd64? ( ${CURI}/${MYPN}3-debian64.tar.gz )
	x86? ( ${CURI}/${MYPN}3-debian32.tar.gz )
	doc? ( ${CURI}/README.pdf -> ${MYPN}.pdf )
	examples? ( ${CURI}/${MYPN}-ex.tar.gz )
	test? ( ${CURI}/${MYPN}-ex.tar.gz )"

RESTRICT="mirror"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="sys-libs/ncurses"
DEPEND=""

S="${WORKDIR}"

src_test() {
	chmod +x ${MYPN}
	ln -s "${EROOT}"/$(get_libdir)/libncurses.so.5 libtinfo.so.5
	ln -s "${EROOT}"/usr/$(get_libdir)/libncurses.so libtinfo.so
	cd ${MYPN}-example/EXAMPLE
	LD_LIBRARY_PATH=../.. ../../${MYPN} ${MYPN}.feedme
}

src_install () {
	dobin ${MYPN}
	# was built on a distro where ncurses was spit with tinfo
	dosym libncurses.so.5 /$(get_libdir)/libtinfo.so.5
	dosym libncurses.so /usr/$(get_libdir)/libtinfo.so

	use doc && newdoc "${DISTDIR}"/${MYPN}.pdf README.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins ${MYPN}-example/*
	fi
}
