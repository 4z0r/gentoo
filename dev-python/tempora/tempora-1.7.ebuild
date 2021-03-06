# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 pypy3 )

inherit distutils-r1

MY_PN="${PN/-/.}"
DESCRIPTION="Objects and routines pertaining to date and time"
HOMEPAGE="https://github.com/jaraco/tempora"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-1.15.0[${PYTHON_USEDEP}]
	doc? (
		>=dev-python/jaraco-packaging-3.2[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		>=dev-python/rst-linker-1.9[${PYTHON_USEDEP}]
	)
	test? (
		>=dev-python/pytest-2.8[${PYTHON_USEDEP}]
		dev-python/backports-unittest-mock[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	PYTHONPATH=. py.test || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( "${BUILD_DIR}"/sphinx/html/. )
	distutils-r1_python_install_all
}
