#!usr/bin/perl -w
use strict;

die "perl $0 [ control.5446.list ] [ ODB8_EukOGs_annotations_Arthropoda-6656.txt ] [output file]\n" unless @ARGV == 3;

my %hash;

open (TB2, "$ARGV[1]") or die "$ARGV[1] $!\n";
while(<TB2>){
	chomp;
	my @line = split;
	shift @line;
	my $id = shift @line;
	#my $line = join "\t", @line; 
	my $line = $line[0]."\t".$line[1]."\t".$line[2];
	$hash{$id} = $line;
}
close TB2;

open (TB1, "$ARGV[0]") or die "$ARGV[0] $!\n";
open (OUT, ">$ARGV[2]") or die "$ARGV[2] $!\n";
my $header = <TB1>;
chomp $header;
print OUT "$header\tevol\tmedian_len\tstd_len\n";
while(<TB1>){
	chomp;
	my @line = split;
	
	print OUT "$_\t$hash{$line[0]}\n";
}
close TB1; 

