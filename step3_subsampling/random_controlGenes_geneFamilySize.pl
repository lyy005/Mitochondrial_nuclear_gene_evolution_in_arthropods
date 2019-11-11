#!usr/bin/perl -w
use strict;
use warnings;
use List::Util qw( shuffle );

die "Usage: perl $0 [ control.gene.list.length ] [ target genes to pick (non-repetitive OR no replacement) ] [ output ] \n" unless (@ARGV == 3);

#my @rand;
my %hash;

open (LST, $ARGV[0]) or die "$ARGV[0] $!\n";
open (TAR, $ARGV[1]) or die "$ARGV[1] $!\n";
open TMP, ">$ARGV[2].tmp" or die "$ARGV[2].tmp $!\n";

open OUT, ">$ARGV[2]" or die "$ARGV[2] $!\n";

while(<LST>){
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;

	my $key = $line[1]."-".$line[2];
	push @{$hash{$key}}, $line[0];
	#push @rand, $line;
}
close LST;

while(<TAR>){
	chomp;
	my $line = $_;
	my @line = split /\s+/, $line;
	
	my $key = $line[1]."-".$line[2];
	if($hash{$key}){
		my $matches = @{$hash{$key}};
		print "$line[0]\t$key\t$matches\n";
		
		my @random = @{$hash{$key}};
		@random = shuffle @random;
		print TMP "$random[0]\n";
		
	}else{
		print "$line[0]\t$key\t0\n";
	}
}
close TAR;
close TMP;

open (IN1, "$ARGV[2].tmp") or die "$ARGV[2].tmp $!\n";
open (IN2, "concatenation.gene.list") or die "concatenation.gene.list $!\n";

my %gene;
while(<IN1>){
	chomp;
	#print;
	$gene{$_} = 1;
}
close IN1;

while(<IN2>){
	chomp;
	# control.EOG8003Z8.fasta.random.GBlocks.fas
	if(/control\.(\w+)\.fasta\.random\.GBlocks\.fas/){
		if($gene{$1}){
			print OUT "$_\n";
		}
	}
}
print "Done!\n";
#my @random = shuffle @rand;
#print OUT join "\n", @random[0..$ARGV[1]-1];
#print OUT "\n";
#close OUT;
#print "DONE!";
