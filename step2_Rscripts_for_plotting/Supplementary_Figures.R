library(reshape2)
library(ggplot2)
library(gridExtra)

setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/step3_evol_rate/")

rate <- read.table("./new/all_rate_order.terminal.table")

# Figure S1
# The evolutionary rate of different gene categories within insect groups

hym <- subset(rate, order =="Hymenoptera")
hd <- subset(rate, hd =="HD")
ohd <- subset(hd, order !="Hymenoptera")
d <- subset(rate, hd =="D")

d <- d[c(3,15:22)]
ohd <- ohd[c(3,15:22)]
hym <- hym[c(3,15:22)]

hym2 <- melt(hym, id=c("style"))
ohd2 <- melt(ohd, id=c("style"))
d2 <- melt(d, id=c("style"))

p1 <- ggplot(d2, aes(x = variable, y = value)) + 
  geom_violin(color='#F8766D') + geom_jitter(color='#F8766D') + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("Diploids") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
p2 <- ggplot(hym2, aes(x = variable, y = value)) + 
  geom_violin(color='#00BA38') + geom_jitter(color='#00BA38') + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("Hymenoptera") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
p3 <- ggplot(ohd2, aes(x = variable, y = value)) + 
  geom_violin(color='#619CFF') + geom_jitter(color='#619CFF') + 
  coord_cartesian(ylim = c(0, 0.02)) +
  theme_bw() + ylab("Other haplodiploids") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 

grid.arrange(p1, p2, p3, ncol=1)


# Figure S2
# copy number
###
setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/scripts_v180623/")

rate <- read.table("all_rate_order.terminal.table")
rate <- rate[order(rate$spp),]

# nucOXPHOS
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.nucOXPHOS.list.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.rRNAproteinCombined.list.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.mtGO.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.werrenGenes.list.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.cytosolicrRNAprotein.list.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.control.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/flybaseID.control_single.output.geneNumber", header = TRUE)


y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

#s <- aggregate(y[, 1:(ncol(y)-3)], list(Name=y$style), mean)
#s2 <- melt(s, id.vars = c("Name"))

plot_ly(data = s2, x = ~Name, y = ~value, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~Name, text = ~variable)

# calculate median and sd
hym <- subset(y, style == "Hymenoptera")     # Hymenoptera
d <- subset(y, style == "Diploids")     # Diploid
hd <- subset(y, style == "Other haplodiploids")     # other hds

median(d$avg)
sd(d$avg)

median(hym$avg)
sd(hym$avg)

median(hd$avg)
sd(hd$avg)


# Figure S2 and S3
## copy number vs evolutionary rate
setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/")

x <- read.table("flybaseID.nucOXPHOS.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style
p1 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("nucOXPHOS genes")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$nucOXPHOS_cp <- y$avg
p12 <- ggplot(rate, aes(x=nucOXPHOS_rate, y=nucOXPHOS_cp, color=style)) + 
  geom_point() + theme_bw() + 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)

# rRNA proteins
x <- read.table("flybaseID.rRNAproteinCombined.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)

p2 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("nucMTrRNAprotein")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$rRNAprotein_cp <- y$avg
p22 <- ggplot(rate, aes(x=nucMTrRNAprotein_rate, y=rRNAprotein_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTrRNAprotein")+ 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# mtGO
x <- read.table("flybaseID.mtGO.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)

p3 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("nucMTGO")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$mtGO_cp <- y$avg
p32 <- ggplot(rate, aes(x=nucMTGO_rate, y=mtGO_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTGO") + 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# Werren genes
x <- read.table("flybaseID.werrenGenes.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)


p4 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("nucMTcor")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$werren_cp <- y$avg
p42 <- ggplot(rate, aes(x=nucMTcor_rate, y=werren_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("nucMTcor")+ 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# cytosolic rRNA
x <- read.table("flybaseID.cytosolicrRNAprotein.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)


p5 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("nucCytosolicrRNAprotein")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$cytosolic_cp <- y$avg
p52 <- ggplot(rate, aes(x=nucCytosolicrRNAprotein_rate, y=cytosolic_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("nucCytosolicrRNAprotein")+ 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# Control single genes
x <- read.table("flybaseID.control_single.output.geneNumber", header = TRUE)

y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)


p6 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("Single control genes")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$controlSingle_cp <- y$avg
p62 <- ggplot(rate, aes(x=nucControlSingle_rate, y=controlSingle_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("Single control genes")+
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# Control genes
#x <- read.table("flybaseID.control.output.geneNumber", header = TRUE)
x <- read.table("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/step3_evol_rate/arthropoda.count.61", header = TRUE)

y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
rownames(y) <- 1:nrow(y)

y$avg <- rowMeans(y[,-ncol(y)])
y$hd <- rate$hd
y$style <- rate$style

plot_ly(data = y, x = ~style, y = ~avg, 
        type = "box", boxpoints = "all", jitter = 0.3,
        color = ~style, text = ~spp)


p7 <- ggplot(y, aes(x = style, y = avg, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 3)) +
  theme_bw() + ylab("Control genes")+ 
  theme(legend.position="none",axis.title.x=element_blank(),panel.grid.minor = element_blank(),panel.grid.major = element_blank())

rate$controlRandom_cp <- y$avg
p72 <- ggplot(rate, aes(x=nucControl_rate, y=controlRandom_cp, color=style)) + 
  geom_point() + theme_bw() + ylab("Control genes")+ 
  theme(legend.position="none",axis.title.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank()) 
#  scale_color_manual(values=c('#619CFF','#F8766D', '#00BA38'))

# Figure S2 - violin plot
grid.arrange(p1, p2, p3, p4, p5, p6, p7, ncol=3)

#  Figure S3 scatterplot
grid.arrange(p12, p22, p32, p42, p52, p62, p72, ncol=3)


### Figure S4: tip to root rate:
library(phytools)
library(ggplot2)
library(gridExtra)
setwd("/Users/yy/Work/local/Projects/OXPHOS_genome/MS/scripts/step3_evol_rate/new/")

##### A. From tip to root

###
# MT genome
###
tree <- read.tree("1_RAxML_result.mtGenome")

d<- node.depth.edgelength(tree)
branchmt <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchmt <- as.data.frame(branchmt)
branchmt$len <- as.numeric(as.character(branchmt$len))
branchmt <- branchmt[order(branchmt$spp),]

###
# nuc OXPHOS
###
tree <- read.tree("2_RAxML_result.nucOXPHOS")

d<- node.depth.edgelength(tree)
branchnucOXPHOS <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchnucOXPHOS <- as.data.frame(branchnucOXPHOS)

branchnucOXPHOS$len <- as.numeric(as.character(branchnucOXPHOS$len))
branchnucOXPHOS <- branchnucOXPHOS[order(branchnucOXPHOS$spp),]

###
# rRNA protein Concatenated
###
tree <- read.tree("3_RAxML_result.rRNAprotein")

d<- node.depth.edgelength(tree)
branchrRNA <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchrRNA <- as.data.frame(branchrRNA)
branchrRNA$len <- as.numeric(as.character(branchrRNA$len))
branchrRNA <- branchrRNA[order(branchrRNA$spp),]

###
# mtGO Concatenated
###
tree <- read.tree("4_RAxML_result.mtGO")

d<- node.depth.edgelength(tree)
branchmtGO <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchmtGO <- as.data.frame(branchmtGO)
branchmtGO$len <- as.numeric(as.character(branchmtGO$len))
branchmtGO <- branchmtGO[order(branchmtGO$spp),]

###
# werren Concatenated
###
tree <- read.tree("5_RAxML_result.RAxML.concatenation.werren")

d<- node.depth.edgelength(tree)
branchwerren <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchwerren <- as.data.frame(branchwerren)
branchwerren$len <- as.numeric(as.character(branchwerren$len))
branchwerren <- branchwerren[order(branchwerren$spp),]

###
# cytosolic rRNA Concatenated
###
tree <- read.tree("6_RAxML_result.cytosolic")

d<- node.depth.edgelength(tree)
branchcyto <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchcyto <- as.data.frame(branchcyto)
branchcyto$len <- as.numeric(as.character(branchcyto$len))
branchcyto <- branchcyto[order(branchcyto$spp),]

###
# control Single Concatenated
###
tree <- read.tree("7_RAxML_result.RAxML.concatenation.controlSingle")

d<- node.depth.edgelength(tree)
branchcon <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchcon <- as.data.frame(branchcon)
branchcon$len <- as.numeric(as.character(branchcon$len))
branchconSingle <- branchcon[order(branchcon$spp),]

###
# control Random Concatenated
###
tree <- read.tree("8_RAxML_result.5480")

d<- node.depth.edgelength(tree)
branchcon <- cbind('spp' = tree$tip.label, 'len' = d[1:76])
branchcon <- as.data.frame(branchcon)
branchcon$len <- as.numeric(as.character(branchcon$len))
branchconRand <- branchcon[order(branchcon$spp),]


###
# Time tree
###
tree <- read.tree("arthropoda3.time.nwk")
# plot(tree)
#plot(tree,no.margin=TRUE,edge.width=2,cex=0.7)
# nodelabels(text=1:tree$Nnode,node=1:tree$Nnode+Ntip(tree), cex=0.5, frame="circle")
#nodelabels(cex=0.5,frame="circle")
#edgelabels(round(tree$edge.length,3),cex=0.8, frame="none", adj = c(0.5, -0.2))
#tiplabels(frame="none")
#add.scale.bar(length = 0.1)

dt <- node.depth.edgelength(tree)
brancht <- cbind('spp' = tree$tip.label, 'time' = dt[1:76])
brancht <- as.data.frame(brancht)
brancht$time <- as.numeric(as.character(brancht$time))
brancht <- brancht[order(brancht$spp),]

##
# combine cols
##
#all_rate <- cbind.data.frame('spp'=as.vector(brancht$spp), 'time'=brancht$time,'mtGenome'=branchmt$len, 'nucOXPHOS'=branchnucOXPHOS$len, 'cplx1' = branch1$cplx1, 'cplx2' = branch2$cplx2, 'cplx3' = branch3$cplx3, 'cplx4' = branch4$cplx4, 'cplx5' = branch5$cplx5, 'rRNAprotein' = branchrRNA$len, 'mtGO' = branchmtGO$len, "werren" = branchwerren$len, "cytosolic" = branchcyto$len, "control" = branchcon$len)
all_rate <- cbind.data.frame('spp' = as.vector(brancht$spp), 'time'=brancht$time, 'mtOXPHOS' = branchmt$len, 'nucOXPHOS'=branchnucOXPHOS$len, 'nucMTrRNAprotein' = branchrRNA$len, 'nucMTGO' = branchmtGO$len, "nucMTcor" = branchwerren$len, "nucCytosolicrRNAprotein" = branchcyto$len, "nucControlSingle" = branchconSingle$len, "nucControlRandom" = branchconRand$len)

all_rate <- as.data.frame(all_rate)
all_rate <- all_rate[order(all_rate$spp),]

# x <- read.table("order.list", header= T)
x <- read.table("order.list.para.id", header= T)
x <- x[order(x$spp),]

#all_rate_order <- cbind('order'=x[,1], 'style' = x[,3], all_rate)
all_rate_order <- cbind('ID' = x[,1], 'order'=x[,2], 'style' = x[,4], 'para' = x[,5], all_rate)

all_rate_order$time <-  as.numeric(as.character(all_rate_order$time))
all_rate_order$nucMTrRNAprotein <- as.numeric(as.character(all_rate_order$nucMTrRNAprotein))
all_rate_order$nucMTGO <-  as.numeric(as.character(all_rate_order$nucMTGO))
all_rate_order$nucMTcor <-  as.numeric(as.character(all_rate_order$nucMTcor))
all_rate_order$nucCytosolicrRNAprotein <-  as.numeric(as.character(all_rate_order$nucCytosolicrRNAprotein))
all_rate_order$mtOXPHOS <- as.numeric(as.character(all_rate_order$mtOXPHOS))
all_rate_order$nucOXPHOS <-  as.numeric(as.character(all_rate_order$nucOXPHOS))
all_rate_order$nucControlSingle <-  as.numeric(as.character(all_rate_order$nucControlSingle))
all_rate_order$nucControlRandom <-  as.numeric(as.character(all_rate_order$nucControlRandom))

all_rate_order$mtOXPHOS_rate <- all_rate_order$mtOXPHOS/ all_rate_order$time
all_rate_order$nucOXPHOS_rate <- all_rate_order$nucOXPHOS/ all_rate_order$time
all_rate_order$nucMTrRNAprotein_rate <- all_rate_order$nucMTrRNAprotein / all_rate_order$time
all_rate_order$nucMTGO_rate <- all_rate_order$nucMTGO / all_rate_order$time
all_rate_order$nucMTcor_rate <- all_rate_order$nucMTcor / all_rate_order$time 
all_rate_order$nucCytosolicrRNAprotein_rate <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$time
all_rate_order$nucControlSingle_rate <- all_rate_order$nucControlSingle / all_rate_order$time
all_rate_order$nucControlRandom_rate <- all_rate_order$nucControlRandom / all_rate_order$time

all_rate_order$mtOXPHOS_rateControlSingle <- all_rate_order$mtOXPHOS/ all_rate_order$nucControlSingle
all_rate_order$nucOXPHOS_rateControlSingle <- all_rate_order$nucOXPHOS/ all_rate_order$nucControlSingle
all_rate_order$nucMTrRNAprotein_rateControlSingle <- all_rate_order$nucMTrRNAprotein / all_rate_order$nucControlSingle
all_rate_order$nucMTGO_rateControlSingle <- all_rate_order$nucMTGO / all_rate_order$nucControlSingle
all_rate_order$nucMTcor_rateControlSingle <- all_rate_order$nucMTcor / all_rate_order$nucControlSingle 
all_rate_order$nucCytosolicrRNAprotein_rateControlSingle <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$nucControlSingle
all_rate_order$nucControlSingle_rateControlSingle <- all_rate_order$nucControlSingle / all_rate_order$nucControlSingle
all_rate_order$nucControlRandom_rateControlSingle <- all_rate_order$nucControlRandom / all_rate_order$nucControlSingle

all_rate_order$mtOXPHOS_rateControlRandom <- all_rate_order$mtOXPHOS/ all_rate_order$nucControlRandom
all_rate_order$nucOXPHOS_rateControlRandom <- all_rate_order$nucOXPHOS/ all_rate_order$nucControlRandom
all_rate_order$nucMTrRNAprotein_rateControlRandom <- all_rate_order$nucMTrRNAprotein / all_rate_order$nucControlRandom
all_rate_order$nucMTGO_rateControlRandom <- all_rate_order$nucMTGO / all_rate_order$nucControlRandom
all_rate_order$nucMTcor_rateControlRandom <- all_rate_order$nucMTcor / all_rate_order$nucControlRandom 
all_rate_order$nucCytosolicrRNAprotein_rateControlRandom <- all_rate_order$nucCytosolicrRNAprotein / all_rate_order$nucControlRandom
all_rate_order$nucControlSingle_rateControlRandom <- all_rate_order$nucControlSingle / all_rate_order$nucControlRandom
all_rate_order$nucControlRandom_rateControlRandom <- all_rate_order$nucControlRandom / all_rate_order$nucControlRandom

all_rate_order$style <- all_rate_order$order
all_rate_order$style <- ifelse(all_rate_order$style == 'Trombidiformes' | all_rate_order$style == 'Mesostigmata' | all_rate_order$style == 'Phthiraptera' | all_rate_order$style == 'Thysanoptera', "Other haplodiploids", 
                               ifelse(all_rate_order$order=='Hymenoptera', "Hymenoptera", "Diploids"))

all_rate_order$hd <- all_rate_order$order
all_rate_order$hd <- ifelse(all_rate_order$hd == 'Trombidiformes' | all_rate_order$hd == 'Mesostigmata' | all_rate_order$hd == 'Phthiraptera' | all_rate_order$hd == 'Thysanoptera', "HD", 
                            ifelse(all_rate_order$order=='Hymenoptera', "HD", "D"))

write.table(all_rate_order, file = "all_rate_order.tip2root.table")

###
# figure S1 - violin plot
###
library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/
all_rate_order <- read.table("all_rate_order.tip2root.table")

my_comparisons <- list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids"))

p1 <- ggplot(all_rate_order, aes(x = style, y = mtOXPHOS_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("mtOXPHOS") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18))
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")

p2 <- ggplot(all_rate_order, aes(x = style, y = nucOXPHOS_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nucOXPHOS") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18))
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")
p3 <- ggplot(all_rate_order, aes(x = style, y = nucMTrRNAprotein_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc MTrRNA") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")
p4 <- ggplot(all_rate_order, aes(x = style, y = nucMTGO_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc MTGO") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
p5 <- ggplot(all_rate_order, aes(x = style, y = nucMTcor_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc MT correlated") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif")
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")
p6 <- ggplot(all_rate_order, aes(x = style, y = nucCytosolicrRNAprotein_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc Cytosolic rRNA") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18))  
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")
p7 <- ggplot(all_rate_order, aes(x = style, y = nucControlSingle_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc Single-copy control") +
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 15))
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
p8 <- ggplot(all_rate_order, aes(x = style, y = nucControlRandom_rate, color=style)) + 
  geom_violin() + geom_jitter() + 
  coord_cartesian(ylim = c(0, 0.0075)) +
  theme_bw() + ylab("nuc control") + 
  theme(legend.position="none",axis.title.x=element_blank(), axis.text.x=element_blank(), panel.grid.minor = element_blank(),panel.grid.major = element_blank(),axis.title.y = element_text(size = 18)) 
#  stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids")),label = "p.signif", hide.ns = TRUE)
#  stat_compare_means(comparisons = my_comparisons,label = "p.signif")

library(cowplot)

row1 <- plot_grid(p1, p2, p3, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row2 <- plot_grid(p4, p5, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)
row3 <- plot_grid(p6, p7,p8, align = 'h', rel_widths = c(1, 1, 1), ncol = 3)

plot_grid(row1, row2, row3, ncol = 1,  hjust = -1, vjust = -1)

