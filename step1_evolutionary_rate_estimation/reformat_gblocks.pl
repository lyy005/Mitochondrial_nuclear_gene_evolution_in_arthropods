#!/usr/bin/perl -w
use strict;

die "perl $0 [GBlocks output *.aln-gb] [output file]\n" unless @ARGV == 2;

open (IN, "$ARGV[0]") or die "$ARGV[0] $!\n";
open (OUT, ">$ARGV[1]") or die "$ARGV[1] $!\n";

$/=">";
<IN>;

my $seq_len;

while(<IN>){
	chomp;
	my $line = $_;
	my @line = split /\n+/, $line;

	my $id = shift @line;
	my @id = split/\s+/,$id;
	my $seq = join "",@line;
	$seq =~s/\s+//g;

	$seq_len = length($seq);

	if($seq_len > 0){
		print OUT ">$id[0]\n$seq\n";
	}
}
close IN;

# if the seq length = 0 bp after GBlocks, do not create the file
if ($seq_len == 0) {system ("rm $ARGV[1]");}
