# step 1 - load packages
library(phytools)
library(ggplot2)
library(gridExtra)
library(ggtree)

###
# set1 - mitochondrial genes
###
tree <- read.tree("./data/set1_mtOXPHOS_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchmt <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchmt <- as.data.frame(branchmt)

#add_t = c("AALBI", "BIMPA", "LRECL")
#add_b = c("NaN", "NaN", "NaN")
#add = data.frame(add_t, add_b)

#branchmt <- data.frame(rbind(as.matrix(branchmt), as.matrix(add)))
branchmt$len <- as.numeric(as.character(branchmt$len))
branchmt <- branchmt[order(branchmt$spp),]

###
# set2 - nucOXPHOS
###
tree <- read.tree("./data/set2_nucOXPHOS_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchnucOXPHOS <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchnucOXPHOS <- as.data.frame(branchnucOXPHOS)

branchnucOXPHOS$len <- as.numeric(as.character(branchnucOXPHOS$len))
branchnucOXPHOS <- branchnucOXPHOS[order(branchnucOXPHOS$spp),]

###
# set2b - nucOXPHOS_without_Complex2
###
tree <- read.tree("./data/set2b_nucOXPHOS_without_Complex2_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchnucOXPHOSN2 <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchnucOXPHOSN2 <- as.data.frame(branchnucOXPHOSN2)

branchnucOXPHOSN2$len <- as.numeric(as.character(branchnucOXPHOSN2$len))
branchnucOXPHOSN2 <- branchnucOXPHOSN2[order(branchnucOXPHOSN2$spp),]

###
# set2c - nucOXPHOS_Complex2
###
tree <- read.tree("./data/set2c_nucOXPHOS_Complex2_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchnucOXPHOS2 <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchnucOXPHOS2 <- as.data.frame(branchnucOXPHOS2)

branchnucOXPHOS2$len <- as.numeric(as.character(branchnucOXPHOS2$len))
branchnucOXPHOS2 <- branchnucOXPHOS2[order(branchnucOXPHOS2$spp),]

###
# set3 - nucMTRP
###
tree <- read.tree("./data/set3_nucMTRP_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchMTRP <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchMTRP <- as.data.frame(branchMTRP)
branchMTRP$len <- as.numeric(as.character(branchMTRP$len))
branchMTRP <- branchMTRP[order(branchMTRP$spp),]

###
# set4 - nucCRP
###
tree <- read.tree("./data/set4_nucCRP_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchCRP <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchCRP <- as.data.frame(branchCRP)
branchCRP$len <- as.numeric(as.character(branchCRP$len))
branchCRP <- branchCRP[order(branchCRP$spp),]

###
# set5 - nucControlSingle
###
tree <- read.tree("./data/set5_nucControlSingle_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchconSin <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchconSin <- as.data.frame(branchconSin)
branchconSin$len <- as.numeric(as.character(branchconSin$len))
branchconSin <- branchconSin[order(branchconSin$spp),]

###
# set6 - nucControl
###
tree <- read.tree("./data/set6_nucControl_RAxML_result.RAxML_output")
d<- node.depth.edgelength(tree)
branchcon <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchcon <- as.data.frame(branchcon)
branchcon$len <- as.numeric(as.character(branchcon$len))
branchcon <- branchcon[order(branchcon$spp),]


###
# Time tree
###
tree <- read.nexus("./data/set7_arthropoda3.time.nwk")
dt <- node.depth.edgelength(tree)
brancht <- cbind('spp' = tree$tip.label, 'time' = dt[1:76])
brancht <- as.data.frame(brancht)
brancht$time <- as.numeric(as.character(brancht$time))
brancht <- brancht[order(brancht$spp),]

###
# plotting
###
#plot(tree,no.margin=TRUE,edge.width=2,cex=0.7)
# nodelabels(text=1:tree$Nnode,node=1:tree$Nnode+Ntip(tree), cex=0.5, frame="circle")
#nodelabels(cex=0.5,frame="circle")
#edgelabels(round(tree$edge.length,3),cex=0.8, frame="none", adj = c(0.5, -0.2))
#tiplabels(frame="none")
#add.scale.bar(length = 0.1)


##
# combine cols
##
all_rate <- cbind.data.frame('spp'=as.vector(brancht$spp), 'time'=brancht$time,'mtGenome'=branchmt$len, 'nucOXPHOS'=branchnucOXPHOS$len, 'nucOXPHOS2'=branchnucOXPHOS2$len, 'nucOXPHOSN2'=branchnucOXPHOSN2$len, 'nucMTRP' = branchMTRP$len, "nucCRP" = branchCRP$len, "controlSingle" = branchconSin$len, "control" = branchcon$len)
all_rate <- as.data.frame(all_rate)
all_rate <- all_rate[order(all_rate$spp),]

# x <- read.table("order.list", header= T)
x <- read.table("./data/order.list.para.id_v20240915", header= T)
x <- x[order(x$spp),]
head(x)

#all_rate_order <- cbind('order'=x[,1], 'style' = x[,3], all_rate)
all_rate_order <- cbind('ID' = x[,1], 'order'=x[,2], 'style' = x[,4], 'style2' = x[,5], 'style3' = x[,6], all_rate)

all_rate_order$nucOXPHOS <- as.numeric(as.character(all_rate_order$nucOXPHOS))
all_rate_order$nucOXPHOS2 <- as.numeric(as.character(all_rate_order$nucOXPHOS2))
all_rate_order$nucOXPHOSN2 <- as.numeric(as.character(all_rate_order$nucOXPHOSN2))
all_rate_order$mtGenome <- as.numeric(as.character(all_rate_order$mtGenome))
all_rate_order$time <-  as.numeric(as.character(all_rate_order$time))
all_rate_order$nucMTRP <-  as.numeric(as.character(all_rate_order$nucMTRP))
all_rate_order$nucCRP <-  as.numeric(as.character(all_rate_order$nucCRP))
all_rate_order$controlSingle <-  as.numeric(as.character(all_rate_order$controlSingle))
all_rate_order$control <-  as.numeric(as.character(all_rate_order$control))

all_rate_order$mtOXPHOS_rate <- all_rate_order$mtGenome / all_rate_order$time
all_rate_order$nucOXPHOS_rate <- all_rate_order$nucOXPHOS / all_rate_order$time
all_rate_order$nucOXPHOS2_rate <- all_rate_order$nucOXPHOS2 / all_rate_order$time
all_rate_order$nucOXPHOSN2_rate <- all_rate_order$nucOXPHOSN2 / all_rate_order$time
all_rate_order$nucMTRP_rate <- all_rate_order$nucMTRP / all_rate_order$time
all_rate_order$nucCRP_rate <- all_rate_order$nucCRP / all_rate_order$time
all_rate_order$controlSingle_rate <- all_rate_order$controlSingle / all_rate_order$time
all_rate_order$control_rate <- all_rate_order$control / all_rate_order$time

# save the table for plotting
write.table(all_rate_order, file = "./data/evolutionary_rate.random.root2tip.table")

# step 2 - plotting
library(ggplot2)
library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

# this table is already shared in the folder. Or you could generate this again by running the step 1 in this script
all_rate_order <- read.table("./data/evolutionary_rate.random.root2tip.table")

head(all_rate_order)

all_rate_order$style2 <- factor(all_rate_order$style2, levels=c("Hymenoptera", "Other haplodiploids", "Diploids"))

my_comparisons <- list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids"), c("Hymenoptera", "Other haplodiploids"))


(p1 <- ggplot(all_rate_order, aes(x = style2, y = mtOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    #ylim(0, 0.007) +
    scale_y_continuous(breaks =seq(0, 0.007, 0.001), limit = c(0, 0.007)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("mtOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p2 <- ggplot(all_rate_order, aes(x = style2, y = nucOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p3 <- ggplot(all_rate_order, aes(x = style2, y = nucMTRP_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucMTRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p4 <- ggplot(all_rate_order, aes(x = style2, y = nucCRP_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucCRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p5 <- ggplot(all_rate_order, aes(x = style2, y = controlSingle_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControlSinlge") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p6 <- ggplot(all_rate_order, aes(x = style2, y = control_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControl") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

# nucOXPHOS without complex2
(p7 <- ggplot(all_rate_order, aes(x = style2, y = nucOXPHOSN2_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Without Complex 2") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

# nucOXPHOS complex2
(p8 <- ggplot(all_rate_order, aes(x = style2, y = nucOXPHOS2_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style2), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style2), position=position_jitter(width = 0.4, height = 0)) + 
    scale_y_continuous(breaks =seq(0, 0.003, 0.001), limit = c(0, 0.003)) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Complex 2") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

# plotting
library(cowplot)
pdf("Figure2.root2tip_distance.pdf", width = 14, height = 12, useDingbats = FALSE) # Open a new pdf file
plot_grid(p1, p2, p3, 
          p7, p8, NULL,
          p4, p5, p6, ncol = 3,  hjust = -1, vjust = -1)
dev.off() # Close the file
