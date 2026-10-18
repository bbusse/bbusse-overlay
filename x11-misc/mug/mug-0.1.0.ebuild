# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

# CRATES generated from this project's Cargo.lock; DESCRIPTION, HOMEPAGE and
# the native dependencies below were filled in by hand.
#
# Upstream mug is presently a macOS-only AppKit app (the cocoa/objc crates
# below, an unconditional `use cocoa::…`, and a `#[cfg(target_os = "macos")]`
# main). It does not build on Linux or BSD yet. This ebuild tracks the dev
# branch so it is ready the moment the StatusNotifierItem backend lands;
# until then an emerge will fail at the compile step. Revisit CRATES, the
# native dependency list and EGIT_COMMIT when that work is merged.

EAPI=8

CRATES="
	bitflags-1.3.2
	block-0.1.6
	cocoa-0.24.1
	cocoa-foundation-0.1.2
	core-foundation-0.9.4
	core-foundation-sys-0.8.7
	core-graphics-0.22.3
	core-graphics-types-0.1.3
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	libc-0.2.177
	malloc_buf-0.0.6
	objc-0.2.7
	once_cell-1.21.3
"

inherit cargo git-r3

DESCRIPTION="Dynamic tray icons driven by a PNG or emoji and a click action"
HOMEPAGE="https://github.com/bbusse/mug"
SRC_URI="$(cargo_crate_uris)"

EGIT_REPO_URI="https://github.com/bbusse/mug.git"
EGIT_BRANCH="dev"
EGIT_COMMIT="bdeca8dc8c5552d33e814f3374f6a8d4f05b3b57"
# mirror, not the default single-branch clone: git-r3 otherwise fetches only
# the branch tip and cannot reference a pinned commit that is not that tip,
# failing the unpack phase with "nonexistent object". vju and scream pin the
# same way
EGIT_CLONE_TYPE="mirror"

# mug itself is BSD-3-Clause; the rest covers the dependency crates and is
# not an exhaustive audit - use cargo-license against the vendor dir for that
LICENSE="BSD Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# The macOS crates above compile to nothing off macOS, so the current tree
# has no native link dependencies on Linux. A StatusNotifierItem tray will
# most likely pull in dev-libs/glib and either x11-libs/gtk+ or a pure
# D-Bus stack - add them here when the backend exists.
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"

# mug is not published to crates.io and has no release tarball, so SRC_URI
# covers only the dependency crates - mug's own source comes from
# EGIT_REPO_URI via git-r3. This must run before cargo_src_unpack, which needs
# Cargo.lock already in ${S} to know what to vendor
src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}
