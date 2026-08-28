# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Reference browser built on the Servo web engine"
HOMEPAGE="https://servo.org"

# Upstream's own vendored release tarball, not cargo_crate_uris: servo pulls
# well over a thousand crates and the vendored tarball ships them alongside a
# .cargo/config.toml that already points cargo at the vendor directory, so the
# build needs no network and the ebuild needs no CRATES list
SRC_URI="https://github.com/servo/servo/releases/download/v${PV}/servo-v${PV}-src-vendored.tar.gz"

# The tarball unpacks to ./ rather than a versioned subdirectory
S="${WORKDIR}"

# servo itself is MPL-2.0; the rest covers the vendored dependency tree, which
# is not exhaustively audited here - run cargo-license against the vendor dir
# for an accurate picture before shipping this anywhere that cares
LICENSE="MPL-2.0 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT Unicode-3.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Translated from upstream's apt_common.txt, which is the closest thing servo
# publishes to a canonical dependency list. gstreamer is not optional: servo's
# media stack is built on it unconditionally
RDEPEND="
	app-arch/xz-utils
	dev-libs/glib:2
	media-libs/freetype:2
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-libs/gstreamer:1.0
	media-libs/harfbuzz:0=
	media-libs/mesa[X,wayland]
	media-libs/vulkan-loader
	sys-apps/dbus
	sys-libs/libunwind:=
	virtual/libudev
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libxcb:0=
	x11-libs/libxkbcommon[X]
"
DEPEND="${RDEPEND}"

# mozjs (SpiderMonkey) is built from source as part of the crate graph and
# needs a full C++ toolchain, cmake and llvm, not just rust
BDEPEND="
	>=dev-lang/rust-1.92.0
	dev-build/cmake
	dev-util/gperf
	llvm-core/clang
	llvm-core/llvm
	sys-devel/m4
	virtual/pkgconfig
"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	default

	# servo pins an exact toolchain (1.92.0 for this release) and cargo will
	# try to fetch it rather than use the system rust, which fails in the
	# sandbox. The tree carries 1.94 and newer, and servo builds on stable,
	# so drop the pin and let portage's rust satisfy BDEPEND instead
	rm -f rust-toolchain.toml || die
}

src_compile() {
	# --offline because everything is vendored; without it cargo still tries
	# to reach crates.io to refresh the index
	cargo build --release --offline --package servoshell || die "cargo build failed"
}

src_install() {
	dobin target/release/servoshell

	# servoshell looks for its resources next to the binary or under a
	# resources path; install them where the packaged binary can find them
	insinto /usr/share/${PN}
	doins -r resources

	einstalldocs
}
