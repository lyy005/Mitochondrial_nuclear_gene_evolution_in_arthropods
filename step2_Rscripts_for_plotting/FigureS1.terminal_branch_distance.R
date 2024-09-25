# step 1 - load libraries and calculate terminal branch length
library(phytools)
library(ggplot2)
library(gridExtra)

###
# set1 - mitochondrial genes
###
tree <- read.tree("./data/set1_mtOXPHOS_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_mtOXPHOS <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_mtOXPHOS)

###
# set2 - nucOXPHOS
###
tree <- read.tree("./data/set2_nucOXPHOS_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucOXPHOS <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucOXPHOS)

###
# set2b - nucOXPHOS_without_Complex2
###
tree <- read.tree("./data/set2b_nucOXPHOS_without_Complex2_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucOXPHOSN2 <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucOXPHOSN2)

###
# set2c - nucOXPHOS_Complex2
###
tree <- read.tree("./data/set2c_nucOXPHOS_Complex2_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucOXPHOS2 <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucOXPHOS2)

###
# set3 - nucMTRP
###
tree <- read.tree("./data/set3_nucMTRP_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucMTRP <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucMTRP)

###
# set4 - nucCRP
###
tree <- read.tree("./data/set4_nucCRP_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucCRP <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucCRP)

###
# set5 - nucControlSingle
###
tree <- read.tree("./data/set5_nucControlSingle_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucControlSingle <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucControlSingle)

###
# set6 - nucControl
###
tree <- read.tree("./data/set6_nucControl_RAxML_result.RAxML_output")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_nucControl <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_nucControl)


###
# Time tree
###
tree <- read.nexus("./data/set7_arthropoda3.time.nwk")

tips <- tree$tip.label
nodes<-sapply(tips,function(x,y) which(y==x),y=tree$tip.label)

terminal<-data.frame(tip=names(nodes), terminal_branch=tree$edge.length[sapply(nodes,function(x,y) which(y==x),y=tree$edge[,2])])
terminal_time <- terminal[order(terminal$tip),]  # sort alphabetically

head(terminal_time)


##
# combine cols
##
terminal_rate <- cbind.data.frame('spp'= as.vector(terminal_time$tip), 
                             'time'= terminal_time$terminal_branch,
                             'mtGenome'= terminal_mtOXPHOS$terminal_branch,
                             'nucOXPHOS'= terminal_nucOXPHOS$terminal_branch,
                             'nucOXPHOS2'= terminal_nucOXPHOS2$terminal_branch,
                             'nucOXPHOSN2'= terminal_nucOXPHOSN2$terminal_branch,
                             'nucMTRP' = terminal_nucMTRP$terminal_branch, 
                             "nucCRP" = terminal_nucCRP$terminal_branch, 
                             "controlSingle" = terminal_nucControlSingle$terminal_branch, 
                             "control" = terminal_nucControl$terminal_branch)
terminal_rate <- as.data.frame(terminal_rate)
terminal_rate <- terminal_rate[order(terminal_rate$spp),]

# x <- read.table("order.list", header= T)
x <- read.table("./data/order.list.para.id_v20240915", header= T)
x <- x[order(x$spp),]
head(x)

#all_rate_order <- cbind('order'=x[,1], 'style' = x[,3], all_rate)
terminal_rate_order <- cbind('ID' = x[,1], 'order'=x[,2], 'style' = x[,4], 'style2' = x[,5], 'style3' = x[,6], terminal_rate)

terminal_rate_order$nucOXPHOS <- as.numeric(as.character(terminal_rate_order$nucOXPHOS))
terminal_rate_order$nucOXPHOS2 <- as.numeric(as.character(terminal_rate_order$nucOXPHOS2))
terminal_rate_order$nucOXPHOSN2 <- as.numeric(as.character(terminal_rate_order$nucOXPHOSN2))
terminal_rate_order$mtGenome <- as.numeric(as.character(terminal_rate_order$mtGenome))
terminal_rate_order$time <-  as.numeric(as.character(terminal_rate_order$time))
terminal_rate_order$nucMTRP <-  as.numeric(as.character(terminal_rate_order$nucMTRP))
terminal_rate_order$nucCRP <-  as.numeric(as.character(terminal_rate_order$nucCRP))
terminal_rate_order$controlSingle <-  as.numeric(as.character(terminal_rate_order$controlSingle))
terminal_rate_order$control <-  as.numeric(as.character(terminal_rate_order$control))

terminal_rate_order$mtOXPHOS_rate <- terminal_rate_order$mtGenome / terminal_rate_order$time
terminal_rate_order$nucOXPHOS_rate <- terminal_rate_order$nucOXPHOS / terminal_rate_order$time
terminal_rate_order$nucOXPHOS2_rate <- terminal_rate_order$nucOXPHOS2 / terminal_rate_order$time
terminal_rate_order$nucOXPHOSN2_rate <- terminal_rate_order$nucOXPHOSN2 / terminal_rate_order$time
terminal_rate_order$nucMTRP_rate <- terminal_rate_order$nucMTRP / terminal_rate_order$time
terminal_rate_order$nucCRP_rate <- terminal_rate_order$nucCRP / terminal_rate_order$time
terminal_rate_order$controlSingle_rate <- terminal_rate_order$controlSingle / terminal_rate_order$time
terminal_rate_order$control_rate <- terminal_rate_order$control / terminal_rate_order$time

# save the table for plotting
write.table(terminal_rate_order, file = "./data/evolutionary_rate.terminal.table")

# step 2 - plotting
library(ggplot2)
library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/
all_rate_order <- read.table("./data/evolutionary_rate.terminal.table")

all_rate_order$style <- factor(all_rate_order$style, levels=c("Hymenoptera", "Other haplodiploids", "Diploids"))
  
my_comparisons <- list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids"), c("Hymenoptera", "Other haplodiploids"))

y <- read.table("/Users/yy16/Work/projects/NotreDame/OXPHOS_genome/MS/scripts/step4_github_submission/evolutionary_rate/data/order.list.para.id4", header= T)
y <- y[order(y$spp),]
all_rate_order <- all_rate_order[order(all_rate_order$spp),]

#all_rate_order_fig2 <- cbind('eusocial'=y[,8], all_rate_order)
#all_rate_order_fig2 <- subset(all_rate_order_fig2, eusocial == "an"|eusocial == "eu")
#all_rate_order_fig2$eusocial <- factor(all_rate_order_fig2$eusocial, levels=c("eu", "an"))

(p1 <- ggplot(all_rate_order, aes(x = style, y = mtOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("mtOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p2 <- ggplot(all_rate_order, aes(x = style, y = nucOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p3 <- ggplot(all_rate_order, aes(x = style, y = nucMTrRNAprotein_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucMTRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )

(p4 <- ggplot(all_rate_order, aes(x = style, y = nucCytosolicrRNAprotein_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucCRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )


(p5 <- ggplot(all_rate_order, aes(x = style, y = nucControlSingle_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControlSinlge") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )


(p6 <- ggplot(all_rate_order, aes(x = style, y = nucControl_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.02) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControl") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif") + 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", hide.ns = FALSE) + 
  scale_color_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) + # red
  scale_fill_manual(values = c("Hymenoptera" = "#00BA38", # green
                               "Other haplodiploids" = "#619CFF", # grey
                                 "Diploids" = "#F8766D")) 
  )



library(cowplot)
pdf("FigureS1.terminal_branch_distance.pdf", width = 15, height = 8, useDingbats = FALSE) # Open a new pdf file
plot_grid(p1, p2, p3, p4, p5, p6, ncol = 3,  hjust = -1, vjust = -1)
dev.off() # Close the file

# step 3 - Kruskal Wallis tests
library(pgirmess)

all_rate_order$style <- as.factor(all_rate_order$style)

# mtOXPHOS
kruskal.test(mtOXPHOS_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$mtOXPHOS_rate, all_rate_order$style, alpha = 0.05)
kruskalmc(all_rate_order$mtOXPHOS_rate, all_rate_order$style, alpha = 0.01)
kruskalmc(all_rate_order$mtOXPHOS_rate, all_rate_order$style, alpha = 0.001)
kruskalmc(all_rate_order$mtOXPHOS_rate, all_rate_order$style, alpha = 0.0001)

# nucOXPHOS
kruskal.test(nucOXPHOS_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucOXPHOS_rate, all_rate_order$style, alpha = 0.05)
kruskalmc(all_rate_order$nucOXPHOS_rate, all_rate_order$style, alpha = 0.01)
kruskalmc(all_rate_order$nucOXPHOS_rate, all_rate_order$style, alpha = 0.001)
kruskalmc(all_rate_order$nucOXPHOS_rate, all_rate_order$style, alpha = 0.0001)

# nucMTRP
kruskal.test(nucMTrRNAprotein_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucMTrRNAprotein_rate, all_rate_order$style, alpha = 0.05)
kruskalmc(all_rate_order$nucMTrRNAprotein_rate, all_rate_order$style, alpha = 0.01)
kruskalmc(all_rate_order$nucMTrRNAprotein_rate, all_rate_order$style, alpha = 0.001)
kruskalmc(all_rate_order$nucMTrRNAprotein_rate, all_rate_order$style, alpha = 0.0001)

# nucCRP
kruskal.test(nucCytosolicrRNAprotein_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucCytosolicrRNAprotein_rate, all_rate_order$style, alpha = 0.05)

# nucControlSinlge
kruskal.test(nucControlSingle_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucControlSingle_rate, all_rate_order$style, alpha = 0.05)

# nucControl_rate
kruskal.test(nucControl_rate ~ style, data=all_rate_order)
kruskalmc(all_rate_order$nucControl_rate, all_rate_order$style, alpha = 0.05)
kruskalmc(all_rate_order$nucControl_rate, all_rate_order$style, alpha = 0.01)
kruskalmc(all_rate_order$nucControl_rate, all_rate_order$style, alpha = 0.001)
kruskalmc(all_rate_order$nucControl_rate, all_rate_order$style, alpha = 0.0001)

#kruskal.test(nucMTGO_rate ~ style, data=rate)
#kruskalmc(rate$nucMTGO_rate, rate$style, alpha = 0.05)

#kruskal.test(nucMTcor_rate ~ style, data=rate)
#kruskalmc(rate$nucMTcor_rate, rate$style, alpha = 0.05)

kruskal.test(cytosolic_rate ~ style, data=tip2root)
kruskalmc(tip2root$cytosolic_rate, tip2root$style, alpha = 0.05)

kruskal.test(controlSingle_rate ~ style, data=tip2root)
kruskalmc(tip2root$nucControlRandom_rate, tip2root$style, alpha = 0.05)

kruskal.test(control_rate ~ style, data=tip2root)
kruskalmc(tip2root$nucControlRandom_rate, tip2root$style, alpha = 0.05)
