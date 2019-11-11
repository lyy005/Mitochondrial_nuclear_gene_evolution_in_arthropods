for file in $(cat gene.list)
do
 echo ${file}
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} oxphos
 perl pick_aa_seq_versionRandom.pl oxphos.${file}.fasta oxphos.${file}.fasta.random
 mafft-linsi oxphos.${file}.fasta.random > oxphos.${file}.fasta.random.aln
 Gblocks oxphos.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S oxphos.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > oxphos.${file}.fasta.random.GBlocks.fas
done
