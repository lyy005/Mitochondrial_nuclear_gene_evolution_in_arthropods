#!usr/bin/perl -w
use strict;

die "perl $0 [fasta] [name list] [output file]\n" unless @ARGV == 3;

my %hash;
open (LS, "$ARGV[1]") or die "$ARGV[0] $!\n";
while(<LS>){
	chomp;
	s/\>//;
	my @line = split;
	$hash{$line[0]} = 1;
}
close LS;

open (IN, "$ARGV[0]") or die "$ARGV[0] $!\n";
open (OUT, ">$ARGV[2]") or die "$ARGV[2] $!\n";
my $header = <IN>;
print OUT $header;

while(<IN>){
	chomp;
	my $all = $_;
	my @line = split /\s+/;

	if($hash{$line[0]}){
		print OUT "$all\n";
	}

}
close IN;
print "Output: $ARGV[2]\n";
