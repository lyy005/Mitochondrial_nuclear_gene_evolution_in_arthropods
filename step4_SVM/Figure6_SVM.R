# haplodiploid info
x <- read.table("all_rate_order.terminal.table")
rate <- x 
rate$style <- rate$order
rate$style <- ifelse(rate$style == 'Trombidiformes' | rate$style == 'Mesostigmata' | rate$style == 'Phthiraptera' | rate$style == 'Thysanoptera', "Other haplodiploids", 
                     ifelse(rate$order=='Hymenoptera', "Hymenoptera", "Diploids"))
rate$hd <- rate$order
rate$hd <- ifelse(rate$hd == 'Trombidiformes' | rate$hd == 'Mesostigmata' | rate$hd == 'Phthiraptera' | rate$hd == 'Thysanoptera', "HD", 
                  ifelse(rate$order=='Hymenoptera', "HD", "D"))
rate <- rate[order(rate$spp),]


# OXPHOS genes
x <- read.table("flybaseID.nucOXPHOS.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("nucOXPHOS", colnames(y), sep = "_")
all <- y

# rRNA genes
x <- read.table("flybaseID.rRNAproteinCombined.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("rRNAprotein", colnames(y), sep = "_")
all <- cbind(all, y)

# MT related GO term genes
x <- read.table("flybaseID.mtGO.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("mtGO", colnames(y), sep = "_")
all <- cbind(all, y)

# MT correlated genes
x <- read.table("flybaseID.nucMTcor.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("werren", colnames(y), sep = "_")
all <- cbind(all, y)

# cytosolic rRNA genes
x <- read.table("flybaseID.cytosolicrRNAprotein.list.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("cytosolic", colnames(y), sep = "_")
all <- cbind(all, y)

# control genes
x <- read.table("flybaseID.control.output.geneNumber", header = TRUE)
y <- as.data.frame(t(x))
y$spp <- row.names(y)
y <- y[order(y$spp),]
y <- y[!grepl("AR[0-9]|HY|LE[0-9]|HE[0-9]|DI|CO[0-9]|X[0-9]", y$spp),]  # remove internal nodes
#rownames(y) <- 1:nrow(y)
y$spp <- NULL
colnames(y) <- paste("control", colnames(y), sep = "_")
all <- cbind(all, y)

# add 
all$style <- rate$hd

# # bees and ants vs. others
y <- read.table("evol_rate/order.list.para.id_svm", header= T)
y <- y[order(y$spp),]

# Boruta ref: https://www.datacamp.com/community/tutorials/feature-selection-R-boruta
library(Boruta)
set.seed(111)
all$style <- as.factor(all$style)
# set up model
boruta.bank_train <- Boruta(style~., data = all, doTrace = 2) 
print(boruta.bank_train)

boruta.bank <- TentativeRoughFix(boruta.bank_train)
print(boruta.bank)

# plot results
#plot(boruta.bank)
plot(boruta.bank, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.bank$ImpHistory),function(i)
  boruta.bank$ImpHistory[is.finite(boruta.bank$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.bank$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(boruta.bank$ImpHistory), cex.axis = 0.7)


getSelectedAttributes(boruta.bank, withTentative = F)

bank_df <- attStats(boruta.bank)
print(bank_df)


