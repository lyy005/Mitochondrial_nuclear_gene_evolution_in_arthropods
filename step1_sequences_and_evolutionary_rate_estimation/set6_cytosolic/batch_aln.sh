for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} cytosolicrRNAprotein
 perl pick_aa_seq_versionRandom.pl cytosolicrRNAprotein.${file}.fasta cytosolicrRNAprotein.${file}.fasta.random
 mafft-linsi cytosolicrRNAprotein.${file}.fasta.random > cytosolicrRNAprotein.${file}.fasta.random.aln
 Gblocks cytosolicrRNAprotein.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S cytosolicrRNAprotein.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > cytosolicrRNAprotein.${file}.fasta.random.GBlocks.fas
done
