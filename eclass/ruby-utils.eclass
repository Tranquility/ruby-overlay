# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby-ng.eclass,v 1.53 2013/12/26 07:11:48 graaff Exp $

# @ECLASS: ruby-utils.eclass
# @MAINTAINER:
# Ruby team <ruby@gentoo.org>
# @AUTHOR:
# Author: Hans de Graaff <graaff@gentoo.org>
# @BLURB: An eclass for supporting ruby scripts and bindings in non-ruby packages
# @DESCRIPTION:
# The ruby-utils eclass is designed to allow an easier installation of
# Ruby scripts and bindings for non-ruby packages.
#
# This eclass does not set any metadata variables nor export any phase
# functions. It can be inherited safely.


case ${EAPI} in
	0|1|2)
		die "Unsupported EAPI=${EAPI} (too old) for ${ECLASS}" ;;
	3|4|5) ;;
	*)
		die "Unknown EAPI=${EAPI} for ${ECLASS}"
esac

if [[ ! ${_RUBY_UTILS} ]]; then


# @ECLASS-VARIABLE: RUBY_TARGETS_PREFERENCE
# @DESCRIPTION:
# This variable lists all the known ruby targets in preference of use as
# determined by the ruby team. By using this ordering rather than the
# USE_RUBY mandated ordering we have more control over which ruby
# implementation will be installed first (and thus eselected). This will
# provide for a better first installation experience.

# All RUBY_TARGETS
RUBY_TARGETS_PREFERENCE="ruby20 ruby19 "

# All other active ruby targets
RUBY_TARGETS_PREFERENCE+="ruby21 rbx jruby "


_ruby_implementation_depend() {
	local rubypn=
	local rubyslot=

	case $1 in
		ruby18)
			rubypn="dev-lang/ruby"
			rubyslot=":1.8"
			;;
		ruby19)
			rubypn="dev-lang/ruby"
			rubyslot=":1.9"
			;;
		ruby20)
			rubypn="dev-lang/ruby"
			rubyslot=":2.0"
			;;
		ruby21)
			rubypn="dev-lang/ruby"
			rubyslot=":2.1"
			;;
		ree18)
			rubypn="dev-lang/ruby-enterprise"
			rubyslot=":1.8"
			;;
		jruby)
			rubypn="dev-java/jruby"
			rubyslot=""
			;;
		rbx)
			rubypn="dev-lang/rubinius"
			rubyslot=""
			;;
		*) die "$1: unknown Ruby implementation"
	esac

	echo "$2${rubypn}$3${rubyslot}"
}



_RUBY_UTILS=1
fi
