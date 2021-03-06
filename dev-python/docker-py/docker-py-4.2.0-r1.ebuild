# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python client for Docker"
HOMEPAGE="https://github.com/docker/docker-py"
SRC_URI="https://github.com/docker/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	!~dev-python/requests-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.32.0[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/paramiko-2.4.2[${PYTHON_USEDEP}]
		>=dev-python/pytest-2.9.1[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}"/${P}-fix_splitnport.patch
)

distutils_enable_sphinx docs \
	'dev-python/recommonmark' \
	'>=dev-python/sphinx-1.4.6'

python_test() {
	pytest -vv tests/unit/ || die "tests failed under ${EPYTHON}"
}
