# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

K3S_TAG="v${PV}+k3s1"

DESCRIPTION="Lightweight Kubernetes"
HOMEPAGE="https://k3s.io https://github.com/k3s-io/k3s"
SRC_URI="
	amd64? ( https://github.com/k3s-io/k3s/releases/download/${K3S_TAG}/k3s -> ${P}-amd64 )
	arm64? ( https://github.com/k3s-io/k3s/releases/download/${K3S_TAG}/k3s-arm64 -> ${P}-arm64 )
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Upstream ships a single static binary with containerd, runc, CNI
# plugins etc. already linked in - there is no source tree to build
# from, and stripping/splitting debug info would break it
RESTRICT="mirror strip"
QA_PREBUILT="usr/bin/${PN}"

src_install() {
	exeinto /usr/bin
	newexe "${DISTDIR}/${P}-${ARCH}" "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"
}
