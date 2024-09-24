set file = `head -n ${SGE_TASK_ID} gene.list | tail -1`
for file in $(cat gene.list)
do
 echo ${file}.fa
 perl pick_aa_seq_v0.9.pl ../aaSeq/${file}.fa ${file} nucMTcor
 perl pick_aa_seq_versionRandom.pl nucMTcor.${file}.fasta nucMTcor.${file}.fasta.random
 mafft-linsi nucMTcor.${file}.fasta.random > nucMTcor.${file}.fasta.random.aln
 Gblocks nucMTcor.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb
 less -S nucMTcor.${file}.fasta.random.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > nucMTcor.${file}.fasta.random.GBlocks.fas
done
