ls *.GBlocks.fas > concatenation.gene.list
perl Concatenation_v1.0.pl concatenation.gene.list concatenation.fasta spp.list

raxmlHPC-PTHREADS -f e -m PROTGAMMAAUTO -s concatenation.fasta -n RAxML_test -T 8 -t arthropod_phylogeny.nwk -o TURTI,ISCAP,MOCCI,CSCUL,LRECL,SMIMO,PTEPI,LHESP
