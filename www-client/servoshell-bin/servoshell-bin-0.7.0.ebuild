# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Reference browser built on the Servo web engine (upstream binary)"
HOMEPAGE="https://servo.org"
SRC_URI="
	amd64? ( https://github.com/servo/servo/releases/download/v${PV}/servo-x86_64-linux-gnu.tar.gz -> ${P}-x86_64-linux-gnu.tar.gz )
	arm64? ( https://github.com/servo/servo/releases/download/v${PV}/servo-aarch64-linux-gnu.tar.gz -> ${P}-aarch64-linux-gnu.tar.gz )
"
S="${WORKDIR}/servo"

LICENSE="MPL-2.0 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT Unicode-3.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	!www-client/servoshell
	dev-libs/glib:2
	dev-libs/wayland
	media-libs/fontconfig
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gstreamer:1.0
	media-libs/libglvnd
	media-libs/vulkan-loader
	sys-libs/zlib
	virtual/libudev
	x11-libs/libxkbcommon
"

QA_PREBUILT="opt/${PN}/servoshell"

src_install() {
	exeinto /opt/${PN}
	doexe servoshell
	insinto /opt/${PN}
	doins -r resources
	dosym -r /opt/${PN}/servoshell /usr/bin/servoshell

	doicon -s scalable resources/servo.svg
	make_desktop_entry servoshell Servo servo "Network;WebBrowser;"
}
