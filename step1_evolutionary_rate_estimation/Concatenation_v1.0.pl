#!usr/bin/perl -w
use strict;

die "Usage: perl $0 [gene.list] [output file] [spp list]\n" unless (@ARGV == 3);
open (LST, $ARGV[0]) or die "$ARGV[0] $!\n";
my (%hash, %length, %spp);
while(<LST>){
       	chomp;
	my $gene = $_;
	open (ALN, $gene) or die "$_ $!\n";
	$/ = ">";
	<ALN>;
	while(<ALN>){
		chomp;
		my @line = split /\n+/, $_;
		my $name = shift @line;
		my @name = split /\_/, $name;
		my $seq = join "", @line;
		$hash{$gene}{$name[0]} = $seq;
		$length{$gene} = length($seq);
# print "###$gene\t$length{$gene}\n";
		$spp{$name[0]} = 1 unless $spp{$name[0]};

	}
	$/ = "\n";
}
close LST;
my %concate;
my @spp;
open (LST, $ARGV[2]) or die "$ARGV[2] $!\n";
while(<LST>){
	chomp;
	my @line = split/\_/;
	push @spp, $line[0];
}


foreach my $k (sort keys %hash){
print "$k\t$length{$k}\n";
	foreach my $l (sort keys %spp){
		if($hash{$k}{$l}){
			$concate{$l} .= $hash{$k}{$l};
#			print "$k\t$l\n";
		}else{
			$concate{$l} .= "-" x $length{$k};
			print "$k\t$l\tNot found, fill in gaps\n";

#my $gap = "-" x $length{$k};
#print "$gap\n";
		}
	}
}
open OT, ">$ARGV[1]" or die "$ARGV[1] $!\n";
#foreach my $k (sort keys %concate){
foreach my $k (sort @spp){
	if($concate{$k}){
		print OT ">$k\n$concate{$k}\n";
#print ">$k\n$concate{$k}\n";
	}else{
		print "$k\n";
	}
}

close OT;
print "DONE!";
