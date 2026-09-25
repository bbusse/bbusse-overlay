# Copyright 2026 Björn Busse <bj.rn@baerlin.eu>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for media-sound/shairport-sync"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( shairport-sync audio )

acct-user_add_deps
