# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="sway"
MY_P="${MY_PN}-${PV}"
WLROOTS_PV="0.20.2"
WLROOTS_P="wlroots-${WLROOTS_PV}"

DESCRIPTION="i3-compatible Wayland compositor, software rendering only via pixman"
HOMEPAGE="https://swaywm.org"
SRC_URI="
	https://github.com/swaywm/${MY_PN}/releases/download/${PV}/${MY_P}.tar.gz -> ${MY_P}.gh.tar.gz
	https://gitlab.freedesktop.org/wlroots/wlroots/-/releases/${WLROOTS_PV}/downloads/${WLROOTS_P}.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="test"

DEPEND="
	>=dev-libs/json-c-0.13:0=
	dev-libs/libevdev
	>=dev-libs/libinput-1.26.0:0=
	dev-libs/libpcre2
	>=dev-libs/wayland-1.24.0
	media-libs/libdisplay-info:=
	sys-apps/hwdata
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/libdrm-2.4.129
	>=x11-libs/libxkbcommon-1.8.0
	x11-libs/pango
	>=x11-libs/pixman-0.43.0
"
RDEPEND="
	${DEPEND}
	x11-misc/xkeyboard-config
	!!gui-wm/sway
"
BDEPEND="
	>=app-text/scdoc-1.11.3
	>=dev-build/meson-1.3
	>=dev-libs/wayland-protocols-1.47
	dev-util/wayland-scanner
	virtual/pkgconfig
"

BUILD_DIR="${WORKDIR}/${MY_P}-build"


src_configure() {
	local wlr_prefix="${WORKDIR}/wlr"
	local BUILD_DIR="${WORKDIR}/${WLROOTS_P}-build"
	local EMESON_SOURCE="${WORKDIR}/${WLROOTS_P}"
	local PKG_CONFIG_PATH
	local emesonargs=(
		--default-library=static
		--prefix="${wlr_prefix}"
		--libdir=lib
		-Drenderers=
		-Dallocators=
		-Dbackends=
		-Dxwayland=disabled
		-Dsession=disabled
		-Dexamples=false
	)

	meson_src_configure
	meson_src_compile
	meson install -C "${BUILD_DIR}" --no-rebuild || die "wlroots install failed"

	BUILD_DIR="${WORKDIR}/${MY_P}-build"
	EMESON_SOURCE="${S}"
	PKG_CONFIG_PATH="${wlr_prefix}/lib/pkgconfig"
	emesonargs=(
		-Dman-pages=enabled
		-Dtray=disabled
		-Dgdk-pixbuf=enabled
		-Dswaybar=true
		-Dswaynag=true
		-Ddefault-wallpaper=false
		-Dbash-completions=true
		-Dfish-completions=true
		-Dzsh-completions=true
	)

	meson_src_configure
}
