for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} nucControlSingle
 perl pick_aa_seq_versionRandom.pl nucControlSingle.${file}.fasta nucControlSingle.${file}.fasta.random
 mafft-linsi nucControlSingle.${file}.fasta.random > nucControlSingle.${file}.fasta.random.aln
 Gblocks nucControlSingle.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S nucControlSingle.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > nucControlSingle.${file}.fasta.random.GBlocks.fas
done
