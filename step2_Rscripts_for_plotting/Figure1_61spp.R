library(phytools)
library(ggplot2)
library(gridExtra)

setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/step4_github_submission/evolutionary_rate/data/")

##### terminal branch

###
# MT genome
###
tree <- read.tree("1_RAxML_result.mtGenome.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalmtGenome <- terminal[order(terminal$tip),]  # sort alphabetically

###
# nucOXPHOS
###
tree <- read.tree("2_RAxML_result.nucOXPHOS.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalnucOXPHOS <- terminal[order(terminal$tip),]  # sort alphabetically

###
# rRNA protein Concatenated
###
tree <- read.tree("3_RAxML_result.rRNAprotein.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalrRNA <- terminal[order(terminal$tip),]  # sort alphabetically

###
# mtGO Concatenated
###
tree <- read.tree("4_RAxML_result.mtGO.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalmtGO <- terminal[order(terminal$tip),]  # sort alphabetically

###
# MTcor Concatenated
###
tree <- read.tree("5_RAxML_result.MTcor.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalwerren <- terminal[order(terminal$tip),]  # sort alphabetically

###
# cytosolic rRNA Concatenated
###
tree <- read.tree("6_RAxML_result.cytosolic.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalcyto <- terminal[order(terminal$tip),]  # sort alphabetically

###
# control Concatenated Single copy
###
tree <- read.tree("7_RAxML_result.RAxML.concatenation.controlSingle.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalcontrolSingle <- terminal[order(terminal$tip),]  # sort alphabetically

###
# control Concatenated random
###
tree <- read.tree("8_RAxML_result.5480.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalcontrolRandom <- terminal[order(terminal$tip),]  # sort alphabetically

###
# Time tree
###
tree <- read.tree("arthropoda3.time.nwk")
# plot(tree)
plot(tree,no.margin=TRUE,edge.width=2,cex=0.7)
# nodelabels(text=1:tree$Nnode,node=1:tree$Nnode+Ntip(tree), cex=0.5, frame="circle")
nodelabels(cex=0.5,frame="circle")
edgelabels(round(tree$edge.length,3),cex=0.8, frame="none", adj = c(0.5, -0.2))
tiplabels(frame="none")
add.scale.bar(length = 0.1)

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminalt <- terminal[order(terminal$tip),]  # sort alphabetically

##
# combine cols
##
#all_rate <- cbind.data.frame('spp' = as.vector(terminalt$tip), 'time'=terminalt$terminal_branch, 'mtGenome' = terminalmtGenome$terminal_branch, 'nucOXPHOS'=terminalnucOXPHOS$terminal_branch, 'cplx1' = terminal1$terminal_branch, 'cplx2' = terminal2$terminal_branch, 'cplx3' = terminal3$terminal_branch, 'cplx4' = terminal4$terminal_branch, 'cplx5' = terminal5$terminal_branch, 'rRNAprotein' = terminalrRNA$terminal_branch, 'mtGO' = terminalmtGO$terminal_branch, "werren" = terminalwerren$terminal_branch, "cytosolic" = terminalcyto$terminal_branch, "control" = terminalcontrol$terminal_branch)
all_rate <- cbind.data.frame('spp' = as.vector(terminalt$tip), 'time'=terminalt$terminal_branch, 'mtOXPHOS' = terminalmtGenome$terminal_branch, 'nucOXPHOS'=terminalnucOXPHOS$terminal_branch, 'nucMTrRNAprotein' = terminalrRNA$terminal_branch, 'nucMTGO' = terminalmtGO$terminal_branch, "nucMTcor" = terminalwerren$terminal_branch, "nucCytosolicrRNAprotein" = terminalcyto$terminal_branch, "nucControlSingle" = terminalcontrolSingle$terminal_branch, "nucControl" = terminalcontrolRandom$terminal_branch)

# all_rate <- as.data.frame(all_rate)

# x <- read.table("order.list", header= T)
x <- read.table("order.list.para.id", header= T)
x <- x[order(x$spp),]

all_rate_order <- cbind('ID' = x[,1], 'order'=x[,2], 'style' = x[,4], 'para' = x[,5], all_rate)
all_rate_order$time <-  as.numeric(as.character(all_rate_order$time))
all_rate_order$nucMTrRNAprotein <- as.numeric(as.character(all_rate_order$nucMTrRNAprotein))
all_rate_order$nucMTGO <-  as.numeric(as.character(all_rate_order$nucMTGO))
all_rate_order$nucMTcor <-  as.numeric(as.character(all_rate_order$nucMTcor))
all_rate_order$nucCytosolicrRNAprotein <-  as.numeric(as.character(all_rate_order$nucCytosolicrRNAprotein))
all_rate_order$mtOXPHOS <- as.numeric(as.character(all_rate_order$mtOXPHOS))
all_rate_order$nucOXPHOS <-  as.numeric(as.character(all_rate_order$nucOXPHOS))
all_rate_order$nucControlSingle <-  as.numeric(as.character(all_rate_order$nucControlSingle))
all_rate_order$nucControl <-  as.numeric(as.character(all_rate_order$nucControl))


all_rate_order$mtOXPHOS_rate <- all_rate_order$mtOXPHOS/ all_rate_order$time
all_rate_order$nucOXPHOS_rate <- all_rate_order$nucOXPHOS/ all_rate_order$time
all_rate_order$nucMTrRNAprotein_rate <- all_rate_order$nucMTrRNAprotein / all_rate_order$time
all_rate_order$nucMTGO_rate <- all_rate_order$nucMTGO / all_rate_order$time
all_rate_order$nucMTcor_rate <- all_rate_order$nucMTcor / all_rate_order$time 
all_rate_order$nucCytosolicrRNAprotein_rate <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$time
all_rate_order$nucControlSingle_rate <- all_rate_order$nucControlSingle / all_rate_order$time
all_rate_order$nucControl_rate <- all_rate_order$nucControl / all_rate_order$time

all_rate_order$mtOXPHOS_rateControlSingle <- all_rate_order$mtOXPHOS/ all_rate_order$nucControlSingle
all_rate_order$nucOXPHOS_rateControlSingle <- all_rate_order$nucOXPHOS/ all_rate_order$nucControlSingle
all_rate_order$nucMTrRNAprotein_rateControlSingle <- all_rate_order$nucMTrRNAprotein / all_rate_order$nucControlSingle
all_rate_order$nucMTGO_rateControlSingle <- all_rate_order$nucMTGO / all_rate_order$nucControlSingle
all_rate_order$nucMTcor_rateControlSingle <- all_rate_order$nucMTcor / all_rate_order$nucControlSingle 
all_rate_order$nucCytosolicrRNAprotein_rateControlSingle <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$nucControlSingle
all_rate_order$nucControlSingle_rateControlSingle <- all_rate_order$nucControlSingle / all_rate_order$nucControlSingle
all_rate_order$nucControl_rateControlSingle <- all_rate_order$nucControl / all_rate_order$nucControlSingle


all_rate_order$mtOXPHOS_rateControl <- all_rate_order$mtOXPHOS/ all_rate_order$nucControl
all_rate_order$nucOXPHOS_rateControl <- all_rate_order$nucOXPHOS/ all_rate_order$nucControl
all_rate_order$nucMTrRNAprotein_rateControl <- all_rate_order$nucMTrRNAprotein / all_rate_order$nucControl
all_rate_order$nucMTGO_rateControl <- all_rate_order$nucMTGO / all_rate_order$nucControl
all_rate_order$nucMTcor_rateControlRll_rate_order$nucMTcor / all_rate_order$nucControl 
all_rate_order$nucCytosolicrRNAprotein_rateControl <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$nucControl
all_rate_order$nucControlSingle_rateControl <- all_rate_order$nucControlSingle / all_rate_order$nucControl
all_rate_order$nucControlRandom_rateControl <- all_rate_order$nucControl / all_rate_order$nucControl

all_rate_order$style <- all_rate_order$order
all_rate_order$style <- ifelse(all_rate_order$style == 'Trombidiformes' | all_rate_order$style == 'Mesostigmata' | all_rate_order$style == 'Phthiraptera' | all_rate_order$style == 'Thysanoptera', "Other haplodiploids", 
                               ifelse(all_rate_order$order=='Hymenoptera', "Hymenoptera", "Diploids"))

all_rate_order$hd <- all_rate_order$order
all_rate_order$hd <- ifelse(all_rate_order$hd == 'Trombidiformes' | all_rate_order$hd == 'Mesostigmata' | all_rate_order$hd == 'Phthiraptera' | all_rate_order$hd == 'Thysanoptera', "HD", 
                            ifelse(all_rate_order$order=='Hymenoptera', "HD", "D"))

write.table(all_rate_order, file = "../output/all_rate_order.terminal.table")

###
# figure 1 - violin plot
###
library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/
all_rate_order <- read.table("all_rate_order.terminal.table")

my_comparisons <- list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids"))

# test without BTERR and BIMPA
all_rate_order <- all_rate_order[!all_rate_order$spp == "BTERR", ]
all_rate_order <- all_rate_order[!all_rate_order$spp == "BIMPA", ]

p1 <- ggplot(all_rate_order, aes(x = style, y = mtOXPHOS_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("mtOXPHOS") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)

p2 <- ggplot(all_rate_order, aes(x = style, y = nucOXPHOS_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nucOXPHOS") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
  
p3 <- ggplot(all_rate_order, aes(x = style, y = nucMTrRNAprotein_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc MTrRNA") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
p4 <- ggplot(all_rate_order, aes(x = style, y = nucMTGO_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc MTGO") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
p5 <- ggplot(all_rate_order, aes(x = style, y = nucMTcor_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc MT correlated") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
p6 <- ggplot(all_rate_order, aes(x = style, y = nucCytosolicrRNAprotein_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc Cytosolic rRNA") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
p7 <- ggplot(all_rate_order, aes(x = style, y = nucControlSingle_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc Single-copy control") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 15)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
p8 <- ggplot(all_rate_order, aes(x = style, y = nucControl_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("nuc 5,480 control genes") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 15)) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)

#pdf("../output/figure1.pdf", width = 12, height = 10) # Open a new pdf file
#grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, ncol=3)
#dev.off() # Close the file

# arrange plots
library(cowplot)

#row1 <- plot_grid(p1, p2, p3, labels = c('A', 'B', 'C'), align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
#row2 <- plot_grid(p4, p5, labels = c('D', 'E'), align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
#row3 <- plot_grid(p6, p7,p8, labels = c('F', 'G', 'H'), align = 'h', rel_widths = c(1, 1, 1), ncol = 3)

row1 <- plot_grid(p1, p2, p3, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row2 <- plot_grid(p4, p5, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row3 <- plot_grid(p6, p7,p8, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)

pdf("../output/figure1.pdf", width = 12, height = 10) # Open a new pdf file
plot_grid(row1, row2, row3, ncol = 1,  hjust = -1, vjust = -1)
dev.off() # Close the file
### 


# Kruskal Wallis test
library(pgirmess)

all_rate_order$style <- as.factor(all_rate_order$style)
rate <- all_rate_order
kruskal.test(mtOXPHOS_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$mtOXPHOS_rate, all_rate_order$style, probs = 0.05)

kruskal.test(nucOXPHOS_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucOXPHOS_rate, all_rate_order$style, probs = 0.05)

kruskal.test(nucMTrRNAprotein_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucMTrRNAprotein_rate, all_rate_order$style, probs = 0.05)

kruskal.test(nucMTGO_rate ~ style, data=rate)
kruskalmc(rate$nucMTGO_rate, rate$style, probs = 0.05)

kruskal.test(nucMTcor_rate ~ style, data=rate)
kruskalmc(rate$nucMTcor_rate, rate$style, probs = 0.05)

kruskal.test(nucCytosolicrRNAprotein_rate ~ style, data=rate)
kruskalmc(rate$nucCytosolicrRNAprotein_rate, rate$style, probs = 0.05)

kruskal.test(nucControlSingle_rate ~ style, data=rate)
kruskalmc(rate$nucControlSingle_rate, rate$style, probs = 0.05)

kruskal.test(nucControlRandom_rate ~ style, data=rate)
kruskalmc(rate$nucControlRandom_rate, rate$style, probs = 0.05)
