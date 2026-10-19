# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A py3status module for querying Datadog metrics and monitors"
HOMEPAGE="https://github.com/bbusse/py3status-datadog"
EGIT_REPO_URI="https://github.com/bbusse/py3status-datadog.git"
EGIT_BRANCH="dev"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-python/datadog-api-client[${PYTHON_USEDEP}]
	x11-misc/py3status[${PYTHON_USEDEP}]
"
