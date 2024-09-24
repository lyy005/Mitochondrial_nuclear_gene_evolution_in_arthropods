#!usr/bin/perl -w
use strict;

die "Usage: perl $0 [aa.fa] [Ortholog ID] [prefix]\n" unless (@ARGV == 3);

my $k = $ARGV[1];


my %ortho;
open (ALL, "../../step0_sequences/arthropoda-ortho-groups.txt") or die "../../step0_sequences/arthropoda-ortho-groups.txt $!\n";
while(<ALL>){
	chomp;
	my @line = split;

	if($line[0] eq $k){
		$ortho{$line[1]} = $line[3];
	}
}

open (FA, $ARGV[0]) or die "$ARGV[0] $!\n";
open OUT, ">$ARGV[2].$k.fasta" or die "$ARGV[2].$k.fasta $!\n";
$/=">";
<FA>;
while(<FA>){
	chomp;
	my $line = $_;
	my @line = split /\n/, $line;
	my $name = shift @line;
	my $seq = join "", @line;
		
	my @name = split /\s+/, $name;

	print "Bad format: $name\n" unless defined $name[0];

	if($ortho{$name[0]}){
#			$name[1] =~ s/\:/\_/;
		my $raxml_name = $name[0];
		$raxml_name =~ s/\:/\_/;
		print OUT ">$ortho{$name[0]}\_$raxml_name\n$seq\n";
	}
}
$/="\n";	
close FA;
close OUT;

print "Output: $ARGV[2].$k.fasta\n";
