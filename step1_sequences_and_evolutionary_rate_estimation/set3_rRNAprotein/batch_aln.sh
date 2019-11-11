for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} rRNAprotein
 perl pick_aa_seq_versionRandom.pl rRNAprotein.${file}.fasta rRNAprotein.${file}.fasta.random
 mafft-linsi rRNAprotein.${file}.fasta.random > rRNAprotein.${file}.fasta.random.aln
 Gblocks rRNAprotein.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S rRNAprotein.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > rRNAprotein.${file}.fasta.random.GBlocks.fas
done
