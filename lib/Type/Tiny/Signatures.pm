# ABSTRACT: Method/Function Signatures w/Type::Tiny Constraints
package Type::Tiny::Signatures;

use 5.14.0;
use strict;
use warnings;

require Function::Parameters;
require Type::Registry;
require Type::Tiny;

our $CALLER = caller;
our @CONFIG = 'Types::Standard';

# VERSION

unshift @Function::Parameters::type_reifiers => sub {
    Type::Registry->for_class($CALLER)->lookup($_[0]);
};

sub import {
    my @LIBRARIES = map { ref $_ ? @$_ : $_ } splice @_, 1;
    Type::Registry->for_class($CALLER)->add_types($_) for @CONFIG, @LIBRARIES;
    Function::Parameters->import;
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Type::Tiny;
    use Type::Tiny::Signatures;

    method hello (Str $greeting, Str $fullname) {
        print "$greeting, $fullname\n";
    }

=head1 DESCRIPTION

This module uses L<Function::Parameters> to extends Perl with keywords that
let you define methods and functions with parameter lists which can be validated
using L<Type::Tiny> type constraints. The type constraints can be provided by
the Type::Tiny standard library, L<Types::Standard>, or any supported
user-defined type library which can be a L<Moose>, L<MooseX::Type>,
L<MouseX::Type>, or L<Type::Library> library.

    use Type::Tiny;
    use Type::Tiny::Signatures qw(MyApp::Types);

The method and function signatures can be configured to incorporate the
user-defined type constraints in routine parameter list validation by passing
the library package name as an argument to the Type::Tiny::Signatures usage
declaration. Please note, the Function::Parameters pragma will be loaded using
the defaults (i.e. not in strict-mode).

=cut

