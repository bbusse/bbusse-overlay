# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

# ::gentoo's ddcutil-2.2.7 ebuild reduced to what the pinned upstream commit
# needs. Pinned past 84421c2 (2026-09-25), which stops rejecting i2c buses
# without a PCI class: on ARM boards the HDMI DDC bus is a plain SoC
# controller (rk3399: ff130000.i2c) and every release up to 3.0.2 ignores it,
# "Bus /dev/i2c-3 cannot be used for DDC/CI communication". Drop this ebuild
# once a release carries the fix

EAPI=8

inherit autotools git-r3 linux-info udev

DESCRIPTION="Program for querying and changing monitor settings"
HOMEPAGE="https://www.ddcutil.com/"
EGIT_REPO_URI="https://github.com/rockowitz/ddcutil.git"
EGIT_COMMIT="9c52490b288baebb919e4e4ce4792b63159e9d84"
# mirror, not the default single-branch clone: git-r3 otherwise fetches only
# the branch tip and cannot reference a pinned commit that is not that tip
EGIT_CLONE_TYPE="mirror"

LICENSE="GPL-2+"
SLOT="0/5"
IUSE="+dbus systemd usb-monitor user-permissions X"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/jansson-2
	sys-apps/i2c-tools
	virtual/acl
	virtual/udev
	x11-libs/libdrm
	dbus? ( sys-apps/dbus )
	systemd? ( sys-apps/systemd )
	usb-monitor? (
		dev-libs/hidapi
		virtual/libusb:1
		sys-apps/usbutils
	)
	user-permissions? ( acct-group/i2c )
	X? (
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libX11
	)
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_pretend() {
	CONFIG_CHECK="~I2C_CHARDEV"
	ERROR_I2C_CHARDEV="You must enable I2C_CHARDEV in your kernel to continue"
	check_extra_config
}

src_prepare() {
	default
	# the test tree still carries -Werror, ::gentoo patches it out
	sed -i 's/ -Werror$//' src/test/Makefile.am || die
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable dbus)
		--enable-drm
		$(use_enable systemd)
		--enable-udev
		$(use_enable usb-monitor usb)
		--enable-lib
		$(use_enable X x11)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	if use user-permissions; then
		udev_dorules data/usr/lib/udev/rules.d/60-ddcutil-i2c.rules
	fi
}

pkg_postinst() {
	use user-permissions && udev_reload
}

pkg_postrm() {
	use user-permissions && udev_reload
}
