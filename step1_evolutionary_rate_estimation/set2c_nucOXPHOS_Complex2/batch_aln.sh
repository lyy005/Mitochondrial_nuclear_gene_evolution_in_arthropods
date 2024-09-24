# copy the gene list including genes exist in at least 61 spp.
less -S ../set0_filter_gene_lists/set2c_nucOXPHOS_Complex2.gene.list.table.61spp | perl -e '<>; while(<>){@a=split; print "$a[0]\n"; }' > gene.list

# read the list of genes
for file in $(cat gene.list)
do
 echo ${file}
 
 # retrieve gene amino acid sequences and rename sequences using species names
 perl pick_aa_seq_v0.9.pl ../../step0_sequences/nuclear_seq/${file}.fa ${file} output

 # if the gene has multiple copies, one random copy will be selected
 perl ../pick_a_random_copy_when_multiple_copies_exist.pl output.${file}.fasta output.${file}.fasta.random

 # align amino acid sequences using mafft-linsi
 mafft-linsi output.${file}.fasta.random > output.${file}.fasta.random.aln

 # use Gblocks to remove regions with bad alignments
 Gblocks output.${file}.fasta.random.aln -t=p -b4=5 -b5=a -e=-gb

 # remove white space introduced by Gblocks
 perl ../reformat_gblocks.pl output.${file}.fasta.random.aln-gb output.${file}.fasta.random.GBlocks.fas

done

# make a list of aligned and clean genes
ls *.GBlocks.fas > concatenation.gene.list

# for 61 spp. + new list of genes
perl ../Concatenation_v1.0.pl concatenation.gene.list concatenation.fasta ../set0_filter_gene_lists/spp.list

# tree building using RAxML with a fixed topology (arthropod_phylogeny.nwk)
#raxmlHPC-PTHREADS -f e -m PROTGAMMAAUTO -s concatenation.fasta -n RAxML_test -T 8 -t ../arthropod_phylogeny.nwk -o TURTI,ISCAP,MOCCI,CSCUL,LRECL,SMIMO,PTEPI,LHESP
