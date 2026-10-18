# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

inherit cargo git-r3

DESCRIPTION="Type into a Wayland compositor from a remote terminal"
HOMEPAGE="https://github.com/bbusse/ssh-keyboard-proxy"
EGIT_REPO_URI="https://github.com/bbusse/ssh-keyboard-proxy.git"

LICENSE="BSD"
LICENSE+=" MIT Unicode-3.0"
SLOT="0"

DEPEND="x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
