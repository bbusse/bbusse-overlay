# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd

DESCRIPTION="AirPlay and AirPlay 2 audio receiver"
HOMEPAGE="https://github.com/mikebrady/shairport-sync"
SRC_URI="https://github.com/mikebrady/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+airplay2 alsa convolution dbus mpris mqtt +pipewire pulseaudio +soxr"
REQUIRED_USE="|| ( alsa pipewire pulseaudio )"

# avahi and openssl are not optional here, AirPlay 2 needs avahi and the
# only other mDNS option is the bundled tinysvcmdns
RDEPEND="
	acct-group/shairport-sync
	acct-user/shairport-sync
	dev-libs/libconfig:=
	dev-libs/openssl:=
	dev-libs/popt
	net-dns/avahi
	airplay2? (
		dev-libs/libgcrypt:=
		app-pda/libplist:=
		dev-libs/libsodium:=
		media-video/ffmpeg:=
		net-misc/nqptp
		sys-apps/util-linux
	)
	alsa? ( media-libs/alsa-lib )
	convolution? ( media-libs/libsndfile )
	dbus? ( dev-libs/glib:2 )
	mpris? ( dev-libs/glib:2 )
	mqtt? ( app-misc/mosquitto )
	pipewire? ( >=media-video/pipewire-1.1.0 )
	pulseaudio? ( media-libs/libpulse )
	soxr? ( media-libs/soxr )
"
DEPEND="${RDEPEND}"
# plistutil comes with libplist, xxd with vim-core
BDEPEND="
	virtual/pkgconfig
	airplay2? ( app-editors/vim-core )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-ssl=openssl \
		--with-avahi \
		--with-metadata \
		$(use_with airplay2 airplay-2) \
		$(use_with alsa) \
		$(use_with convolution) \
		$(use_with dbus dbus-interface) \
		$(use_with mpris mpris-interface) \
		$(use_with mqtt mqtt-client) \
		$(use_with pipewire) \
		$(use_with pulseaudio) \
		$(use_with soxr)
}

# make install already places shairport-sync.conf and the sample under /etc.
# The system unit runs as the shairport-sync user, which cannot reach a
# per-user pipewire or pulseaudio session, so the upstream user unit is
# installed too, with its /usr/local path fixed
src_install() {
	default
	systemd_dounit "scripts/${PN}.service"
	sed -e 's|/usr/local/bin|/usr/bin|' "scripts/${PN}.user.service" \
		> "${T}/${PN}.service" || die
	systemd_douserunit "${T}/${PN}.service"
}
