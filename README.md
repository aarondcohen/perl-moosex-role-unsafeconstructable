# NAME

MooseX::Role::UnsafeConstructable - construct an object without type-checks

# VERSION

Version 0.03

# SYNOPSIS

This module provides the method _unsafe\_new_ which allows the caller to
construct an instance while bypassing all access controls and type constraints.
This is useful when the caller knows and trusts the source of the
initialization data and doesn't want to choose between performance in a corner
case and data integrity of the overall system.

Example usage:

        package Foo;
        use Moose;
        with 'MooseX::Role::UnsafeConstructable';

        has field => (is => 'ro', isa => 'HashRef[ArrayRef[Str]]');

        __PACKAGE__->meta->make_immutable;

        package main;

        my $foo = Foo->unsafe_new(field => {this => [qw{that and another}]});
                # => is a Foo, but instantiated faster

# METHODS

## declare\_unsafe\_class

Declare the shadow class to be used for unsafe instantiation.  Any class using
MooseX::Role::UnsafeConstructable role will call declare\_unsafe\_class
automatically when made immutable.  Otherwise, declare\_unsafe\_class must be
called after the original class is fully declared to ensure all attributes are
properly shadowed.

For each attribute, the shadow class will preserve:
name, default, builder, and init\_arg.  All other options will be dropped.  This
should provide behavior that mostly matches normal instantiation, with the one
caveat that any field declared uninitializable (with init\_arg => undef) can now
be set.  This is considered a feature, not a bug.

## unsafe\_class

Return the name of the shadow class used for unsafe instantiation.

## unsafe\_new

Instantiate the class, bypassing access and type constraints.

# AUTHOR

Aaron Cohen, `<aarondcohen at gmail.com>`

# ACKNOWLEDGEMENTS

This module was made possible by [Shutterstock](http://www.shutterstock.com/)
([@ShutterTech](https://twitter.com/ShutterTech)).  Additional open source
projects from Shutterstock can be found at
[code.shutterstock.com](http://code.shutterstock.com/).

# BUGS

Please report any bugs or feature requests to `bug-MooseX-Role-UnsafeConstructable at rt.cpan.org`, or through
the web interface at [https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable/issues](https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable/issues).  I will
be notified, and then you'll automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MooseX::Role::UnsafeConstructable

You can also look for information at:

- Official GitHub Repo

    [https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable](https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable)

- GitHub's Issue Tracker (report bugs here)

    [https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable/issues](https://github.com/aarondcohen/perl-moosex-role-unsafeconstructable/issues)

- CPAN Ratings

    [http://cpanratings.perl.org/d/MooseX-Role-UnsafeConstructable](http://cpanratings.perl.org/d/MooseX-Role-UnsafeConstructable)

- Official CPAN Page

    [http://search.cpan.org/dist/MooseX-Role-UnsafeConstructable/](http://search.cpan.org/dist/MooseX-Role-UnsafeConstructable/)

# LICENSE AND COPYRIGHT

Copyright 2014 Aaron Cohen.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
