for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} mtGO
 perl pick_aa_seq_versionRandom.pl mtGO.${file}.fasta mtGO.${file}.fasta.random
 mafft-linsi mtGO.${file}.fasta.random > mtGO.${file}.fasta.random.aln
 Gblocks mtGO.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S mtGO.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > mtGO.${file}.fasta.random.GBlocks.fas
done
