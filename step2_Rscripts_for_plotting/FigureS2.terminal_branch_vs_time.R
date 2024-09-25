library(ggfortify)
library(ggrepel)

# step 1 - plotting
rate <- read.table("./data/evolutionary_rate.terminal.table")

(p1 <- ggplot(rate, aes(x = time, y = mtOXPHOS_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("mtOXPHOS") + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)
  
(p2 <- ggplot(rate, aes(x = time, y = nucOXPHOS_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("nucOXPHOS") + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)

(p3 <- ggplot(rate, aes(x = time, y = nucMTRP_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("nucMTRP") + 
    # xlim(0, 600) + ylim(0, 0.016) + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)

(p4 <- ggplot(rate, aes(x = time, y = nucCRP_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("nucCRP") + 
    # xlim(0, 600) + ylim(0, 0.016) + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)

(p5 <- ggplot(rate, aes(x = time, y = controlSingle_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("nucControlSingle") + 
    #xlim(0, 600) + ylim(0, 0.016) + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)

(p6 <- ggplot(rate, aes(x = time, y = control_rate, color = style2, fill = style2)) + 
  geom_point(size = 3) + theme_bw() + ylab("nucControl") + 
  theme(legend.position="none",
        axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_fill_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) + 
    scale_color_manual(values = c("Hymenoptera" = "#00BA38", "Other haplodiploids" = "#619CFF", "Diploids" = "#F8766D")) 
)


library(gridExtra)
pdf("FigureS2.terminal_branch_vs_time.pdf", width = 15, height = 8) # Open a new
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3)
dev.off() # Close the file


# step 2 - correlation test
test <- rate
test <- subset(rate, style2 =="Diploids") # diploid species
test <- subset(rate, order =="Hymenoptera")     #Hymenoptera
test <- subset(rate, style2 =="Other haplodiploids") # other haplodiploid species

pvalue <- cor.test(test$mtOXPHOS_rate, test$time, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$nucOXPHOS_rate, test$time, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$nucMTrRNAprotein_rate, test$time, method="spearman")$p.value
#cor.test(test$nucMTGO_rate, test$time, method="spearman")
#cor.test(test$nucMTcor_rate, test$time, method="spearman")
pvalue[[length(pvalue)+1]] <- cor.test(test$nucCytosolicrRNAprotein_rate, test$time, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$nucControlSingle_rate, test$time, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$nucControl_rate, test$time, method="spearman")$p.value
pvalue_adjusted <- p.adjust(pvalue, method="holm",n = length(pvalue))
cat(pvalue_adjusted,sep="\n")

est <- cor.test(test$mtOXPHOS_rate, test$time, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$nucOXPHOS_rate, test$time, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$nucMTrRNAprotein_rate, test$time, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$nucCytosolicrRNAprotein_rate, test$time, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$nucControlSingle_rate, test$time, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$nucControl_rate, test$time, method="spearman")$estimate
cat(est,sep="\n")


# paired outputs rho and p-values
cor.test(test$mtOXPHOS_rate, test$time, method="spearman")$estimate
cor.test(test$mtOXPHOS_rate, test$time, method="spearman")$p.value

cor.test(test$nucOXPHOS_rate, test$time, method="spearman")$estimate
cor.test(test$nucOXPHOS_rate, test$time, method="spearman")$p.value

cor.test(test$nucMTrRNAprotein_rate, test$time, method="spearman")$estimate
cor.test(test$nucMTrRNAprotein_rate, test$time, method="spearman")$p.value

cor.test(test$nucCytosolicrRNAprotein_rate, test$time, method="spearman")$estimate
cor.test(test$nucCytosolicrRNAprotein_rate, test$time, method="spearman")$p.value

cor.test(test$nucControlSingle_rate, test$time, method="spearman")$estimate
cor.test(test$nucControlSingle_rate, test$time, method="spearman")$p.value

cor.test(test$nucControl_rate, test$time, method="spearman")$estimate
cor.test(test$nucControl_rate, test$time, method="spearman")$p.value
