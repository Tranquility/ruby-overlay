# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_PV=${PV/./.r}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Shoes is a very informal graphics and windowing toolkit for Ruby."
HOMEPAGE="http://shoesrb.com/"
SRC_URI="http://dev.a3li.li/gentoo/distfiles/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="video"

USE_RUBY="ruby18"

RDEPEND="x11-libs/gtk+:2
	>=media-libs/giflib-4.1.6-r1
	>=x11-libs/cairo-1.6.4-r1[svg]
	>=x11-libs/pango-1.20.5
	>=media-libs/jpeg-6b-r8
	=dev-lang/ruby-1.8*
	>=dev-ruby/rubygems-1.2.0
	>=net-misc/curl-7.18.2
	dev-db/sqlite:3
	video? ( >=media-video/vlc-0.9.6 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf=""

	use video && myconf="VIDEO=1"

	emake  ${myconf} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc CHANGELOG README || die
}

pkg_postinst(){
	einfo
	einfo "You can find the samples into the"
	einfo "/usr/local/lib/shoes/samples/ directory."
	einfo
}
