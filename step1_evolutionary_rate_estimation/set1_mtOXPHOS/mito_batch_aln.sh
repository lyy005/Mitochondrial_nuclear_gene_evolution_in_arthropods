# the script for mitochondrial genes is a bit different from nuclear genes
# fasta files for mitochondrial genes are organized differently than nuclear genes 
# as the mitochondrial genes are usually not included in OrthoDB

# read the list of mitochondrial genes
for file in $(cat gene.list)
do 
 echo ${file}.noStopCodon.fasta

 # copy the mitochondrial genes to current directory
 cp ../step0_sequences/${file}.noStopCodon.fasta ./

 # align amino acid sequences using mafft-linsi
 mafft-linsi ${file}.noStopCodon.fasta > ${file}.fasta.aln

 # use Gblocks to remove regions with bad alignments
 Gblocks ${file}.fasta.aln -t=p -b4=5 -b5=a -e=-gb

 # remove white space introduced by Gblocks
 #less -S ${file}.fasta.aln-gb| perl -e '$/ = ">"; <>; while(<>){chomp; @line=split/\n+/; my $name = shift @line; @name=split/\s+/, $name; my $seq = join "",@line; $seq =~s/\s+//g; print ">$name[0]\n$seq\n";}' > ${file}.fasta.GBlocks
 perl ../reformat_gblocks.pl ${file}.fasta.aln-gb ${file}.fasta.GBlocks.fas
done

# make a list of aligned and clean genes
ls *.GBlocks.fas > concatenation.gene.list

# concatenate genes into one for RAxML
perl ../Concatenation_v1.0.pl concatenation.gene.list concatenation.fasta ../set0_filter_gene_lists/spp.list

# tree building using RAxML with a fixed topology (arthropod_phylogeny.nwk)
#raxmlHPC-PTHREADS -f e -m PROTGAMMAAUTO -s concatenation.fasta -n RAxML_test -T 8 -t ../arthropod_phylogeny.nwk -o TURTI,ISCAP,MOCCI,CSCUL,LRECL,SMIMO,PTEPI,LHESP
