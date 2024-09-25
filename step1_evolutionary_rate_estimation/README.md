# Estimate evolutionary rates

## 1. Pick OrthoDB groups exist in at least 61 spp.
 
Run the cmd.sh script under ./set0_filter_gene_lists/

## 2. Mitochondrial genes

Run the mito_batch_aln.sh script under ./set1_mtOXPHOS/ to align and make a phylogenetic tree for mitochondrial genes

## 3. Nuclear genes

Under each nuclear gene set directory, i.e. set2_nucOXPHOS, set2b_nucOXPHOS_without_Complex2, set2c_nucOXPHOS_Complex2, set3_nucMTRP, set4_nucCRP, set5_nucControlSingle, set6_nucControl, run the batch_aln.sh script. 
