#!usr/bin/perl -w
use strict;

die "Usage: perl $0 [arthropoda-ortho-groups.txt] [order.list.para.id] [out table]\n" unless (@ARGV == 2);
open (TAB, $ARGV[0]) or die "$ARGV[0] $!\n";

open OUT, ">$ARGV[1]" or die "$ARGV[2] $!\n";

my %hash;
open (IN, "order.list.para.id") or die "order.list.para.id $!\n";
while(<IN>){
	my $line = $_;
	my @line = split /\s+/, $line;
	$order{$line[2]} = $line[3];
}
close IN;

while(<TAB>){
	chomp;
	my @line = split /\s+/, $_;
	$hash{$line[0]}{$line[3]} ++;
}
close TAB;

my $gene_number = keys %hash;
print "# genes: $gene_number\n";

print OUT "gene\torder\t#spp\tmedian\tSD\n";

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

sub median
{
    my @vals = sort {$a <=> $b} @_;
    my $len = @vals;
    if($len%2) #odd?
    {
        return $vals[int($len/2)];
    }
    else #even
    {
        return ($vals[int($len/2)-1] + $vals[int($len/2)])/2;
    }
}

sub stdev{
        my($data) = @_;
        if(@$data == 1){
                return 0;
        }
        my $average = &average($data);
        my $sqtotal = 0;
        foreach(@$data) {
                $sqtotal += ($average-$_) ** 2;
        }
        my $std = ($sqtotal / (@$data-1)) ** 0.5;
        return $std;
}
