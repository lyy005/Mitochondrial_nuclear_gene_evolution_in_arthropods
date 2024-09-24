#!/bin/bash

for file in $(cat gene.list)
do 
 echo ${file}.noStopCodon.fasta
 mafft-linsi ${file}.noStopCodon.fasta > ${file}.fasta.aln
 Gblocks ${file}.fasta.aln -t=p -b4=5 -b5=a -e=-gb
 less -S ${file}.fasta.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > ${file}.fasta.GBlocks
done
