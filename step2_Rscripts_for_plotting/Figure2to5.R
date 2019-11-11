library(reshape)
library(plyr)
library(scales)
library(ggplot2)
library(ggrepel)
library(picante)
library(gridExtra)
library(plotly)
library(pgirmess)

setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/step4_github_submission/evolutionary_rate/")

rate <- read.table("./data/all_rate_order.terminal.table")
#rate <- read.table("all_rate_order.tip2root.table")

####
# Figure 2a - scaled by time
####
test <- rate # all the insects
#test <- subset(rate, style =="Diploids") # diploid species
#test <- subset(rate, order =="Hymenoptera")     #Hymenoptera
#test <- subset(rate, style =="Other haplodiploids") # other haplodiploid species


pvalue <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTrRNAprotein_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTGO_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTcor_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucCytosolicrRNAprotein_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucControlSingle_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucControl_rate, method="spearman")$p.value
pvalue_adjusted <- p.adjust(pvalue, method="holm",n = length(pvalue))
cat(pvalue_adjusted,sep="\n")

est <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTrRNAprotein_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTGO_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTcor_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucCytosolicrRNAprotein_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucControlSingle_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucControl_rate, method="spearman")$estimate
cat(est,sep="\n")

p1 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucOXPHOS_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucOXPHOS") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20)) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))
p2 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucMTrRNAprotein_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p3 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucMTGO_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTGO") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p4 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucMTcor_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTcor") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p5 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucCytosolicrRNAprotein_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucCytosolicrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p6 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucControlSingle_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucControlSingle") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p7 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucControl_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucControl") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))

pdf("./output/figure2A.pdf", width = 12, height = 10) # Open a new
grid.arrange(p1, p2, p3, p4, p5, p6, p7, ncol = 3)
dev.off() # Close the file


# figure 2b by controlSingle
test <- rate # all species
#test <- subset(rate, style =="Diploids") # diploid species
#test <- subset(rate, order =="Hymenoptera")     #Hymenoptera
#test <- subset(rate, style =="Other haplodiploids") # other haplodiploid species

pvalue <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucOXPHOS_rateControlSingle, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTrRNAprotein_rateControlSingle, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTGO_rateControlSingle, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTcor_rateControlSingle, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucCytosolicrRNAprotein_rateControlSingle, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucControl_rateControlSingle, method="spearman")$p.value
pvalue_adjusted <- p.adjust(pvalue, method="holm",n = length(pvalue))
cat(pvalue_adjusted,sep="\n")

est <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucOXPHOS_rateControlSingle, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTrRNAprotein_rateControlSingle, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTGO_rateControlSingle, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucMTcor_rateControlSingle, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucCytosolicrRNAprotein_rateControlSingle, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControlSingle, test$nucControl_rateControlSingle, method="spearman")$estimate
cat(est,sep="\n")


p1 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucOXPHOS_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucOXPHOS") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20)) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))
p2 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucMTrRNAprotein_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p3 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucMTGO_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTGO") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p4 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucMTcor_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTcor") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p5 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucCytosolicrRNAprotein_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucCytosolicrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p6 <- ggplot(rate, aes(x=mtOXPHOS_rateControlSingle, y=nucControl_rateControlSingle, color=style)) + 
  geom_point() + theme_bw() + ylab("nucControl") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))


pdf("./output/figure2B.pdf", width = 12, height = 10) # Open a new
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3)
dev.off() # Close the file

# Figure 2c by controlRandom
test <- rate
test <- subset(rate, style =="Diploids") # diploid species
test <- subset(rate, order =="Hymenoptera")     #Hymenoptera
test <- subset(rate, style =="Other haplodiploids") # other haplodiploid species

pvalue <- cor.test(test$mtOXPHOS_rateControl, test$nucOXPHOS_rateControl, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTrRNAprotein_rateControl, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTGO_rateControl, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTcor_rateControl, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucCytosolicrRNAprotein_rateControl, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucControlSingle_rateControl, method="spearman")$p.value
pvalue_adjusted <- p.adjust(pvalue, method="holm",n = length(pvalue))
cat(pvalue_adjusted,sep="\n")

est <- cor.test(test$mtOXPHOS_rateControl, test$nucOXPHOS_rateControl, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTrRNAprotein_rateControl, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTGO_rateControl, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucMTcor_rateControl, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucCytosolicrRNAprotein_rateControl, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rateControl, test$nucControlSingle_rateControl, method="spearman")$estimate
cat(est,sep="\n")

p1 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucOXPHOS_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucOXPHOS") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20)) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))
p2 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucMTrRNAprotein_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p3 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucMTGO_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTGO") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p4 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucMTcor_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTcor") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p5 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucCytosolicrRNAprotein_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucCytosolicrRNAprotein") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))
p6 <- ggplot(rate, aes(x=mtOXPHOS_rateControl, y=nucControlSingle_rateControl, color=style)) + 
  geom_point() + theme_bw() + ylab("nucControlSingle") +
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),text = element_text(size=20))


pdf("./output/figure2C.pdf", width = 12, height = 10) # Open a new
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3)
dev.off() # Close the file

##
# Figure 3 - PCA
## ref: http://huboqiang.cn/2016/03/03/RscatterPlotPCA

y <- read.table("./data/order.list.para.id4", header= T)
y <- y[order(y$spp),]

rate <- rate[order(rate$spp),]

rate$para <- y$style2
rate$para2 <- y$parasite

#pca <- rate[c(3:5,11:14,16 )]
pca <- rate[c(5,15:22)] # with MT geens

pca1 <- pca
row.names(pca1) <- pca1$spp
pca1$spp <- NULL
pca_out <- prcomp(pca1)
pca_out1 <- as.data.frame(pca_out$x)
pca_out1$hd <- rate$hd

# plot with loading values
library(ggfortify)
library(ggrepel)

pdf("./output/figure3.pdf", width = 12, height = 10) # Open a new
autoplot(pca_out, data=rate, colour='style', 
         loadings = T, loadings.colour = 'black',
         loadings.label = T, loadings.label.size = 3, loadings.label.colour = 'black', 
         label.size=8, loadings.label.vjust = 1.2) + 
  scale_color_manual(values = c("#F8766D","#00BA38","#619CFF")) + 
  #geom_text_repel(aes(label=spp),size=3) + 
  theme_bw() + 
  theme(legend.position="none",panel.grid.minor = element_blank(),panel.grid.major = element_blank()) + 
  geom_point(aes(colour=factor(style), shape = factor(para2), size = 0.2))
dev.off() # Close the file

             
###
# Figure 4 
###
y <- read.table("./data/order.list.para.id4", header= T)
y <- y[order(y$spp),]

rate$para <- y$style2
rate$para2 <- y$parasite

hym <- subset(rate, para =="an" | para =="eu")
hym$para <- factor(hym$para)
hym$spp <- factor(hym$spp)

## most recent script
pca$style <- y$style2
pca$para <- y$parasite
p1 <- ggplot(pca, aes(x=mtOXPHOS_rate, y=nucOXPHOS_rate, color=style)) + 
  geom_point(size = 3) + theme_bw() +ylab("nuclear OXPHOS genes") + 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), text = element_text(size=20)) +
  #  scale_color_manual(values=c("#00BA38","#F8766D","#619CFF")) + 
  geom_point(aes(shape = factor(para), size = 3))
  #geom_text_repel(aes(label=rate$spp),hjust=0, vjust=0)

p2 <- ggplot(pca, aes(x=mtOXPHOS_rate, y=nucControl_rate, color=style)) + 
  geom_point(size = 3) + theme_bw() + ylab("nuclear control genes") + 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), text = element_text(size=20)) + 
  geom_point(aes(shape = factor(para), size = 3))
  #geom_text_repel(aes(label=rate$spp),hjust=0, vjust=0)

ggplot(pca, aes(x=nucOXPHOS_rate, y=nucControl_rate, color=style)) + 
  geom_point(size = 3) + theme_bw() + xlab("nuclear OXPHOS genes") + ylab("nuclear control genes") + 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(), text = element_text(size=20)) + 
  geom_point(aes(shape = factor(para), size = 3))

pdf("./output/figure4.pdf", width = 12, height = 5) # Open a new
grid.arrange(p1, p2, ncol = 2)
dev.off() # Close the file

# Figure 5
library(ggfortify)
library(ggrepel)
y <- read.table("./data/order.list.para.id4", header= T)
y <- y[order(y$spp),]

rate$style <- y$style2
rate$para <- y$parasite
p1 <- ggplot(rate, aes(x=time, y=mtOXPHOS_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("mtOXPHOS") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p2 <- ggplot(rate, aes(x=time, y=nucOXPHOS_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nucOXPHOS") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p3 <- ggplot(rate, aes(x=time, y=nucMTrRNAprotein_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc MTrRNA") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p4 <- ggplot(rate, aes(x=time, y=nucMTGO_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc MTGO") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p5 <- ggplot(rate, aes(x=time, y=nucMTcor_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc MT correlated") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p6 <- ggplot(rate, aes(x=time, y=nucCytosolicrRNAprotein_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc Cytosolic rRNA") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p7 <- ggplot(rate, aes(x=time, y=nucControlSingle_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc Single-copy control") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))

p8 <- ggplot(rate, aes(x=time, y=nucControl_rate, color=style)) + 
  geom_point() + theme_bw() + ylab("nuc control") + 
  theme(legend.position="none",axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(), text = element_text(size=20))  + 
  geom_point(aes(shape = factor(para), size = 1))


library(cowplot)

row1 <- plot_grid(p1, p2, p3, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row2 <- plot_grid(p4, p5, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row3 <- plot_grid(p6, p7,p8, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)

pdf("./output/figure5.pdf", width = 12, height = 9) # Open a new
plot_grid(row1, row2, row3, ncol = 1,  hjust = -1, vjust = -1)
dev.off() # Close the file


# correlation test
test <- rate
test <- subset(rate, style =="Diploids") # diploid species
test <- subset(rate, order =="Hymenoptera")     #Hymenoptera
test <- subset(rate, style =="Other haplodiploids") # other haplodiploid species

cor.test(test$mtOXPHOS_rate, test$time, method="spearman")
cor.test(test$nucOXPHOS_rate, test$time, method="spearman")
cor.test(test$nucMTrRNAprotein_rate, test$time, method="spearman")
cor.test(test$nucMTGO_rate, test$time, method="spearman")
cor.test(test$nucMTcor_rate, test$time, method="spearman")
cor.test(test$nucCytosolicrRNAprotein_rate, test$time, method="spearman")
cor.test(test$nucControlSingle_rate, test$time, method="spearman")
cor.test(test$nucControl_rate, test$time, method="spearman")
