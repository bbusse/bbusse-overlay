# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

# CRATES generated from this project's Cargo.lock; DESCRIPTION, HOMEPAGE and
# the native dependencies below were translated from the APKBUILD in the
# scream repo, which is the equivalent Alpine packaging

EAPI=8

CRATES="
	anstream-0.6.21
	anstyle-1.0.13
	anstyle-parse-0.2.7
	anstyle-query-1.1.5
	anstyle-wincon-3.0.11
	atomic_refcell-0.1.13
	autocfg-1.5.0
	bitflags-2.10.0
	cc-1.2.52
	cfg-expr-0.15.8
	cfg-if-1.0.4
	clap-4.5.54
	clap_builder-4.5.54
	clap_derive-4.5.49
	clap_lex-0.7.6
	colorchoice-1.0.4
	downcast-rs-1.2.1
	either-1.15.0
	equivalent-1.0.2
	errno-0.3.14
	fastrand-2.3.0
	find-msvc-tools-0.1.7
	futures-channel-0.3.31
	futures-core-0.3.31
	futures-executor-0.3.31
	futures-io-0.3.31
	futures-macro-0.3.31
	futures-sink-0.3.31
	futures-task-0.3.31
	futures-util-0.3.31
	getrandom-0.3.4
	gio-0.18.4
	gio-sys-0.18.1
	glib-0.18.5
	glib-macros-0.18.5
	glib-sys-0.18.1
	gobject-sys-0.18.0
	gstreamer-0.21.3
	gstreamer-app-0.21.2
	gstreamer-app-sys-0.21.1
	gstreamer-base-0.21.2
	gstreamer-base-sys-0.21.1
	gstreamer-net-0.21.3
	gstreamer-net-sys-0.21.0
	gstreamer-rtsp-0.21.0
	gstreamer-rtsp-server-0.21.2
	gstreamer-rtsp-server-sys-0.21.2
	gstreamer-rtsp-sys-0.21.1
	gstreamer-sdp-0.21.1
	gstreamer-sdp-sys-0.21.0
	gstreamer-sys-0.21.2
	hashbrown-0.16.1
	heck-0.4.1
	heck-0.5.0
	indexmap-2.13.0
	is_terminal_polyfill-1.70.2
	itertools-0.12.1
	libc-0.2.180
	linux-raw-sys-0.11.0
	memchr-2.7.6
	memmap2-0.9.9
	muldiv-1.0.1
	num-integer-0.1.46
	num-rational-0.4.2
	num-traits-0.2.19
	once_cell-1.21.3
	once_cell_polyfill-1.70.2
	option-operations-0.5.0
	paste-1.0.15
	pin-project-lite-0.2.16
	pin-utils-0.1.0
	pkg-config-0.3.32
	pretty-hex-0.4.1
	proc-macro-crate-2.0.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.105
	quick-xml-0.41.0
	quote-1.0.43
	r-efi-5.3.0
	rustix-1.1.3
	serde-1.0.228
	serde_core-1.0.228
	serde_derive-1.0.228
	serde_spanned-0.6.9
	shlex-1.3.0
	signal-hook-0.3.18
	signal-hook-registry-1.4.8
	slab-0.4.11
	smallvec-1.15.1
	strsim-0.11.1
	syn-1.0.109
	syn-2.0.114
	system-deps-6.2.2
	target-lexicon-0.12.16
	tempfile-3.24.0
	thiserror-1.0.69
	thiserror-impl-1.0.69
	toml-0.8.2
	toml_datetime-0.6.3
	toml_edit-0.20.2
	unicode-ident-1.0.22
	utf8parse-0.2.2
	version-compare-0.2.1
	version_check-0.9.5
	wasip2-1.0.1+wasi-0.2.4
	wayland-backend-0.3.16
	wayland-client-0.31.15
	wayland-protocols-0.32.13
	wayland-scanner-0.31.11
	wayland-sys-0.31.11
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-link-0.2.1
	windows-sys-0.61.2
	winnow-0.5.40
	wit-bindgen-0.46.0
"

inherit cargo git-r3

DESCRIPTION="Wayland RTSP server using ext-image-copy-capture-v1 for screencopy"
HOMEPAGE="https://github.com/bbusse/scream"
SRC_URI="$(cargo_crate_uris)"

EGIT_REPO_URI="https://github.com/bbusse/scream.git"
EGIT_BRANCH="dev"
EGIT_COMMIT="56705f3b000524d7cd64a4e628a4e18cbb7c9902"
# mirror, not the default single-branch clone: git-r3 otherwise fetches only
# the branch tip and cannot reference a pinned commit that is not that tip,
# failing the unpack phase with "nonexistent object". vju pins the same way
EGIT_CLONE_TYPE="mirror"

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
