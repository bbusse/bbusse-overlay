# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Query Datadog metrics, monitors and incidents from the shell"
HOMEPAGE="https://github.com/bbusse/pyqdd"
EGIT_REPO_URI="https://github.com/bbusse/pyqdd.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	>=dev-python/datadog-api-client-2.0.0[${PYTHON_USEDEP}]
"
