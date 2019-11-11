#!usr/bin/perl -w
use strict;
use warnings;
use List::Util qw( shuffle );

die "Usage: perl $0 [ control.gene.list ] [number of random genes to pick (non-repetitive OR no replacement) ] [ output ] \n" unless (@ARGV == 3);

my @rand;

open (LST, $ARGV[0]) or die "$ARGV[0] $!\n";
open OUT, ">$ARGV[2]" or die "$ARGV[2] $!\n";

while(<LST>){
	chomp;
	my $line = $_;
	push @rand, $line;
}
close LST;


my @random = shuffle @rand;
print OUT join "\n", @random[0..$ARGV[1]-1];
print OUT "\n";
close OUT;
print "DONE!";
