#!usr/bin/perl -w
use strict;

die "Usage: perl $0 [arthropoda-ortho-groups.txt] [out table]\n" unless (@ARGV == 2);
open (TAB, $ARGV[0]) or die "$ARGV[0] $!\n";
open OUT, ">$ARGV[1]" or die "$ARGV[2] $!\n";

my %hash;
my %spp;
while(<TAB>){
	chomp;
	my @line = split /\s+/, $_;
	$hash{$line[0]}{$line[3]} ++;
}
close TAB;

my $gene_number = keys %hash;
print "# genes: $gene_number\n";

print OUT "gene\tspp\tsumOfgenes\n";

foreach my $k (sort keys %hash){
	my $spp = keys %{$hash{$k}};
	my $sum;
	foreach my $j (sort keys %{$hash{$k}}){
		$sum += $hash{$k}{$j};
	}

	print OUT "$k\t$spp\t$sum\n";
}

close OUT;
print "DONE!";
