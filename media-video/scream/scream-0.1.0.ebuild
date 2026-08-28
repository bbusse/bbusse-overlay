# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

# CRATES generated from this project's Cargo.lock; DESCRIPTION, HOMEPAGE and
# the native dependencies below were translated from the APKBUILD in the
# scream repo, which is the equivalent Alpine packaging

EAPI=8

CRATES="
	anstream-1.0.0
	anstyle-1.0.14
	anstyle-parse-1.0.0
	anstyle-query-1.1.5
	anstyle-wincon-3.0.11
	atomic_refcell-0.1.14
	autocfg-1.5.1
	bitflags-2.13.1
	cc-1.4.3
	cfg-expr-0.20.8
	cfg-if-1.0.4
	clap-4.6.6
	clap_builder-4.6.6
	clap_derive-4.6.4
	clap_lex-1.1.0
	colorchoice-1.0.5
	downcast-rs-1.2.1
	either-1.17.0
	equivalent-1.0.2
	errno-0.3.14
	fastrand-2.5.0
	find-msvc-tools-0.1.11
	futures-channel-0.3.34
	futures-core-0.3.34
	futures-executor-0.3.34
	futures-io-0.3.34
	futures-macro-0.3.34
	futures-sink-0.3.34
	futures-task-0.3.34
	futures-util-0.3.34
	getrandom-0.4.3
	gio-0.22.8
	gio-sys-0.22.8
	glib-0.22.8
	glib-macros-0.22.6
	glib-sys-0.22.8
	gobject-sys-0.22.6
	gstreamer-0.25.3
	gstreamer-app-0.25.2
	gstreamer-app-sys-0.25.0
	gstreamer-base-0.25.3
	gstreamer-base-sys-0.25.3
	gstreamer-net-0.25.0
	gstreamer-net-sys-0.25.0
	gstreamer-rtsp-0.25.0
	gstreamer-rtsp-server-0.25.2
	gstreamer-rtsp-server-sys-0.25.0
	gstreamer-rtsp-sys-0.25.2
	gstreamer-sdp-0.25.3
	gstreamer-sdp-sys-0.25.0
	gstreamer-sys-0.25.2
	hashbrown-0.17.1
	heck-0.5.0
	indexmap-2.14.0
	is_terminal_polyfill-1.70.2
	itertools-0.15.0
	kstring-2.0.4
	libc-0.2.189
	linux-raw-sys-0.12.1
	memchr-2.8.3
	memmap2-0.9.11
	muldiv-1.0.1
	num-integer-0.1.47
	num-rational-0.4.2
	num-traits-0.2.19
	once_cell-1.21.4
	once_cell_polyfill-1.70.2
	option-operations-0.6.1
	pastey-0.2.3
	pin-project-lite-0.2.17
	pkg-config-0.3.34
	proc-macro2-1.0.107
	quick-xml-0.41.0
	quote-1.0.47
	r-efi-6.0.0
	rustix-1.1.4
	serde_core-1.0.229
	serde_derive-1.0.229
	serde_spanned-1.1.1
	shlex-2.0.1
	signal-hook-0.3.18
	signal-hook-registry-1.4.8
	slab-0.4.12
	smallvec-1.15.2
	static_assertions-1.1.0
	strsim-0.11.1
	syn-2.0.119
	syn-3.0.3
	system-deps-7.0.8
	target-lexicon-0.13.5
	tempfile-3.27.0
	thiserror-2.0.20
	thiserror-impl-2.0.20
	toml-1.1.4+spec-1.1.0
	toml_datetime-1.1.1+spec-1.1.0
	toml_parser-1.1.3+spec-1.1.0
	toml_writer-1.1.2+spec-1.1.0
	unicode-ident-1.0.24
	utf8parse-0.2.2
	version-compare-0.2.1
	wayland-backend-0.3.17
	wayland-client-0.31.15
	wayland-protocols-0.32.13
	wayland-scanner-0.31.11
	wayland-sys-0.31.11
	windows-link-0.2.1
	windows-sys-0.61.2
	winnow-1.0.4
"

inherit cargo git-r3

DESCRIPTION="Wayland RTSP server using ext-image-copy-capture-v1 for screencopy"
HOMEPAGE="https://github.com/bbusse/scream"
SRC_URI="$(cargo_crate_uris)"

EGIT_REPO_URI="https://github.com/bbusse/scream.git"
EGIT_COMMIT="cb6c75f8259107bb8aacd42c6b656b6a818f4a92"

# scream itself is BSD-3-Clause; the rest covers the dependency crates and is
# not an exhaustive audit - use cargo-license against the vendor dir for that
LICENSE="BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 ISC MIT MPL-2.0 Unicode-3.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# gstreamer is the media pipeline and gst-rtsp-server the server itself, so
# neither is optional. The plugin sets carry the encoders the pipeline uses
RDEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-libs/gst-rtsp-server:1.0
	media-libs/gstreamer:1.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"

# scream is not published to crates.io and has no release tarball, so SRC_URI
# covers only the dependency crates - scream's own source comes from
# EGIT_REPO_URI via git-r3. This must run before cargo_src_unpack, which needs
# Cargo.lock already in ${S} to know what to vendor
src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}
