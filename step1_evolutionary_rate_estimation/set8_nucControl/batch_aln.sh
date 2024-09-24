for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} nucControl
 perl pick_aa_seq_versionRandom.pl nucControl.${file}.fasta nucControl.${file}.fasta.random
 mafft-linsi nucControl.${file}.fasta.random > nucControl.${file}.fasta.random.aln
 Gblocks nucControl.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S nucControl.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > nucControl.${file}.fasta.random.GBlocks.fas
done
