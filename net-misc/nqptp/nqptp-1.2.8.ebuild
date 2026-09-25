# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

DESCRIPTION="Not Quite PTP, the timing daemon shairport-sync needs for AirPlay 2"
HOMEPAGE="https://github.com/mikebrady/nqptp"
SRC_URI="https://github.com/mikebrady/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_prepare() {
	default
	eautoreconf
}

# The unit runs nqptp as a DynamicUser with CAP_NET_BIND_SERVICE for the
# PTP ports 319 and 320
src_install() {
	default
	systemd_dounit "${PN}.service"
}
