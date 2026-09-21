# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

# Upstream Gentoo's sys-boot/refind builds from source and only supports
# amd64/x86 (no aa64 EFIARCH), so it cannot produce refind_aa64.efi for the
# arm64 boards. This installs upstream's prebuilt EFI binary for the build
# arch instead, so systemd-boot can chainload rEFInd on every board

EAPI=8

DESCRIPTION="rEFInd boot manager, prebuilt EFI binary"
HOMEPAGE="https://www.rodsbooks.com/refind/"
SRC_URI="https://downloads.sourceforge.net/project/refind/${PV}/refind-bin-${PV}.zip"
S="${WORKDIR}/refind-bin-${PV}"

LICENSE="GPL-3+ BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="app-arch/unzip"

# Prebuilt EFI binaries, do not strip or scan them
RESTRICT="strip"
QA_PREBUILT="usr/share/refind/refind_*.efi"

src_install() {
	local efiarch
	case "${ARCH}" in
	amd64) efiarch=x64 ;;
	x86) efiarch=ia32 ;;
	arm64) efiarch=aa64 ;;
	*) die "refind-bin: no prebuilt EFI binary for ARCH ${ARCH}" ;;
	esac

	insinto /usr/share/refind
	doins "refind/refind_${efiarch}.efi"
}
