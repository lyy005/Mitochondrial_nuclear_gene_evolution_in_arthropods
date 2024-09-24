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
	$spp{$line[3]} ++;
}
close TAB;

my $gene_number = keys %hash;
my $spp_number = keys %spp;
print "# genes: $gene_number\n";
print "# spp: $spp_number\n";

print OUT "gene\tspp\tsumOfgenes\n";

foreach my $k (sort keys %hash){
	my $spp = keys %{$hash{$k}};
	my $sum = 0;
	my $dup = 0;
	foreach my $j (sort keys %{$hash{$k}}){
		if($hash{$k}{$j} == 1){
			$sum ++;
		}else{
			$dup = 1;
		}
	}
	if(($sum >= 60)&&($dup == 0)){
		print OUT "$k\t$spp\t$sum\n";
	}
}

close OUT;
print "DONE!";
