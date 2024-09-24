#!usr/bin/perl -w
use strict;

die "perl $0 [ concatenate.gene.list ] [ gene.table.61 ] [ 61 concatenate gene list ]\n" unless @ARGV == 3;

my %hash;
open (LS, "$ARGV[1]") or die "$ARGV[0] $!\n";
while(<LS>){
	chomp;
	my @line = split;
	$hash{$line[0]} = 1;
}
close LS;

open (IN, "$ARGV[0]") or die "$ARGV[0] $!\n";
open (OUT, ">$ARGV[2]") or die "$ARGV[2] $!\n";
while(<IN>){
	chomp;
	my $all = $_;
	my @line = split /\./;
	my $id = $line[1];

	if($hash{$id}){
		print OUT "$all\n";
	}else{
		print "Removed: $all\n";
	}
}
close IN;
print "Done\n";
