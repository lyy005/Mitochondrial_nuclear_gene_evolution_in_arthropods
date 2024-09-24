#!usr/bin/perl -w
use strict;

die "Usage: perl $0 [aa.fa] [output]\n" unless (@ARGV == 2);

my (%seq, %rand);

open (FA, $ARGV[0]) or die "$ARGV[0] $!\n";
open OUT, ">$ARGV[1]" or die "$ARGV[1] $!\n";
$/=">";
<FA>;
while(<FA>){
	chomp;
	my $line = $_;
	my @line = split /\n/, $line;
	my $name = shift @line;
	my $seq = join "", @line;
	
	$seq{$name} = $seq;
	
	my @name = split /\_/, $name;
	push @{$rand{$name[0]}}, $name;
}
close FA;

foreach my $k (keys %rand){
	my $rand = ${$rand{$k}}[rand @{$rand{$k}}];
	print OUT ">$rand\n$seq{$rand}\n";
}
close OUT;
print "DONE!";
