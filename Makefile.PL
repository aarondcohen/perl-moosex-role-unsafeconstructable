use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
	NAME                => 'MooseX::Role::UnsafeConstructable',
	AUTHOR              => q{Aaron Cohen <acohen@shutterstock.com>},
	VERSION_FROM        => 'lib/MooseX/Role/UnsafeConstructable.pm',
	ABSTRACT_FROM       => 'lib/MooseX/Role/UnsafeConstructable.pm',
);
