#!/usr/bin/env perl

use strict;
use warnings;

use FindBin ();
use lib "$FindBin::Bin/../lib";

use Test::Most tests => 20;

{
	package Foo;
	use Moose;
	with 'MooseX::Role::UnsafeConstructable';

	has val1 => (is => 'ro', isa => 'Str');
	has val2 => (is => 'ro', isa => 'Str', default => 'mom');
	has val3 => (is => 'ro', isa => 'Str', default => sub { 'dad' });
	has val4 => (is => 'ro', isa => 'Str', builder => '_build_val4');
	has val5 => (is => 'ro', isa => 'Str', init_arg => undef);
	has _val6 => (is => 'ro', isa => 'Str', init_arg => 'val6');

	sub _build_val4 { 'bro' }
}

my $class = 'Foo';

dies_ok { $class->unsafe_class->new } 'Must call declare_unsafe_class to build an unsafe class';

$class->declare_unsafe_class;

lives_ok { $class->declare_unsafe_class } 'declare_unsafe_class is safe to call multiple times';

is $class->unsafe_class, "$class\::Unsafe";

isa_ok $class->new, $class;
isa_ok $class->unsafe_new, $class;
isa_ok $class->unsafe_class->new, $class->unsafe_class;
isa_ok $class->unsafe_class->new->promote, $class;
is $class->unsafe_new->val1, undef;
is $class->unsafe_new->val2, 'mom';
is $class->unsafe_new->val3, 'dad';
is $class->unsafe_new->val4, 'bro';
is $class->unsafe_new->val5, undef;
is $class->unsafe_new->_val6, undef;

dies_ok { $class->new(val1 => [qw{invalid array}]) };

for my $attr (qw{val1 val2 val3 val4 val5}) {
	is $class->unsafe_new($attr => 'bonkers')->$attr, 'bonkers';
}
is $class->unsafe_new(val6 => 'bonkers')->_val6, 'bonkers';
