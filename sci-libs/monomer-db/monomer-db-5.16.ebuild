# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="refmac_dictionary"

DESCRIPTION="Monomer library used for macromolecular structure building and refinement."
HOMEPAGE="www.ccp4.ac.uk"
SRC_URI="http://www.ysbl.york.ac.uk/~garib/refmac/data/refmac_experimental/${MY_PN}_v${PV}.tar.gz"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	!<sci-chemistry/ccp4-6.1
	!<sci-libs/ccp4-libs-6.1.1-r1
"
DEPEND="${RDEPEND}"

RESTRICT="binchecks strip"

S="${WORKDIR}"/monomers

src_install() {
	insinto /usr/share/ccp4/data/monomers/
	for i in {a..z} {0..9} *list *.cif *.txt; do
		doins -r ${i} || die
	done
	dodoc *.txt *.ps || die
	dohtml *.html || die
}