wget ftp://cegg.unige.ch/OrthoDB8/Eukaryotes/Annot_to_OGs/ODB8_EukOGs_annotations_Arthropoda-6656.txt.gz

# merge two tables
perl combine_tables.pl control.5446.list ODB8_EukOGs_annotations_Arthropoda-6656.txt control.5446.list.length


# get the genes of control genes
awk -F '.' '{print $2}' ../nuclear_aa/nucOXPHOS/concatenation.gene.list > nucOXPHOS.gene.list

# control gene list
le control.5446.list.length | awk '{print $1}' > control.gene.list


# random 1
perl random_controlGenes.pl control.gene.list 59 control_random1.list

# random by gene number

###
# randomization based on family size
###
## get gene size information from 
perl pick_sequences_on_list.pl control.5746.list.length nucOXPHOS.gene.list nucOXPHOS.gene.list.length

awk -F '.' '{print $2}' nucMTrRNAprotein.gene.list.filename > nucMTrRNAprotein.gene.list
perl pick_sequences_on_list.pl control.5746.list.length nucMTrRNAprotein.gene.list nucMTrRNAprotein.gene.list.length

## randomization based on family size
perl random_controlGenes_geneFamilySize.pl control.5746.list.length nucOXPHOS.gene.list.length nucOXPHOS.gene.list.length.output
perl random_controlGenes_geneFamilySize.pl control.5746.list.length nucMTrRNAprotein.gene.list.length nucMTrRNAprotein.gene.list.length.output
