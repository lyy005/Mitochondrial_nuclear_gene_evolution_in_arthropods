# unzip amino acid sequences of all nuclear genes
unzip arthropoda-seqs-all.zip

# mitochondrial gene sequences are under
ll ../set1_mtOXPHOS/

# check the distribution of genes
# only genes exist in >=80% of 76 arthropod species (i.e. 76 * 0.8 = 61 species) will be used for downstream analysis
perl summary_gene_distribution.pl arthropoda-ortho-groups.txt distribution.table

# pick orthologs in the follow categories
## set2_nucOXPHOS
perl pick_sequences_on_list.pl distribution.table set2_nucOXPHOS.gene.list set2_nucOXPHOS.gene.list.table
awk '($2 >= 61){print}' set2_nucOXPHOS.gene.list.table > set2_nucOXPHOS.gene.list.table.61spp

## set2b_nucOXPHOS_without_Complex2
perl pick_sequences_on_list.pl distribution.table set2b_nucOXPHOS_without_Complex2.gene.list set2b_nucOXPHOS_without_Complex2.gene.list.table
awk '($2 >= 61){print}' set2b_nucOXPHOS_without_Complex2.gene.list.table > set2b_nucOXPHOS_without_Complex2.gene.list.table.61spp

## set2c_nucOXPHOS_Complex2
perl pick_sequences_on_list.pl distribution.table set2c_nucOXPHOS_Complex2.gene.list set2c_nucOXPHOS_Complex2.gene.list.table
awk '($2 >= 61){print}' set2c_nucOXPHOS_Complex2.gene.list.table > set2c_nucOXPHOS_Complex2.gene.list.table.61spp

## set3_nucMTRP
perl pick_sequences_on_list.pl distribution.table set3_nucMTRP.gene.list set3_nucMTRP.gene.list.table
awk '($2 >= 61){print}' set3_nucMTRP.gene.list.table > set3_nucMTRP.gene.list.table.61spp

## set4_nucCRP
perl pick_sequences_on_list.pl distribution.table set4_CRP.gene.list set4_CRP.gene.list.table
awk '($2 >= 61){print}' set4_CRP.gene.list.table > set4_CRP.gene.list.table.61spp

## set5_nucControlSingle
perl pick_sequences_on_list.pl distribution.table set5_nucControlSingle.gene.list set5_nucControlSingle.gene.list.table
awk '($2 >= 61){print}' set5_nucControlSingle.gene.list.table > set5_nucControlSingle.gene.list.table.61spp

## set6_nucControl
#perl pick_sequences_on_list.pl distribution.table set6_nucControl.gene.list set6_nucControl.gene.list.table
#awk '($2 >= 61){print}' set6_nucControl.gene.list.table > set6_nucControl.gene.list.table.61spp
awk '($2 >= 61){print}' distribution.table > distribution.table.61
perl pick_sequences_on_list.pl distribution.table set6_nucControl.gene.list set6_nucControl.gene.list.table
awk '($2 >= 61){print}' set6_nucControl.gene.list.table > set6_nucControl.gene.list.table.61spp
