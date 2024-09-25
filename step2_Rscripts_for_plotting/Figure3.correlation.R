library(ggplot2)

rate <- read.table("./data/evolutionary_rate.root2tip.table")

head(rate)

# complex 2
(p_complex2 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucOXPHOS2_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() +  
    xlab("mtOXPHOS") + 
    ylab("nucOXPHOS complex 2") + 
    theme(legend.position="none",
        #axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)

# without complex 2
(p_complexN2 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucOXPHOSN2_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() +  
    xlab("mtOXPHOS") + 
    ylab("nucOXPHOS complex 2") + 
  theme(legend.position="none",
        #axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
      scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)

(p1 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucOXPHOS_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() + 
    theme(legend.position="none",
          #axis.title.x=element_blank(), 
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          text = element_text(size=20)) + 
    scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)

(p2 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucMTRP_rate, color = style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() + # ylab("mtOXPHOS") + 
    theme(legend.position="none",
        #axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
  scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)


(p3 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=nucCRP_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() + 
    theme(legend.position="none",
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
    scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)

(p4 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=controlSingle_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() + 
    theme(legend.position="none",
        #axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
      scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)

(p5 <- ggplot(rate, aes(x=mtOXPHOS_rate, y=control_rate, color=style3)) + 
    geom_point() + 
    geom_smooth(color = "black", method=lm, se=FALSE, ) + 
    geom_smooth(aes(color = style), method=lm, se=FALSE) + 
    theme_bw() + # ylab("mtOXPHOS") + 
  # xlim(0, 0.02) + ylim(0, 0.02) + 
  #xlim(0, 0.005) + ylim(0, 0.005) + 
  theme(legend.position="none",
        #axis.title.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        text = element_text(size=20)) + 
      scale_color_manual(values = c("HD_an" = "#00798c", # green
                                "HD" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) # red
)


library(gridExtra)
library(cowplot)
pdf("Figure3.correlation.pdf", width = 15, height = 8) # Open a new
plot_grid(p1, p2, NULL, 
          p_complexN2,p_complex2, NULL,
          p3, p4, p5, ncol = 3)
dev.off() # Close the file

# Spearman correlation test
test <- rate # all the insects
test <- subset(rate, style =="D") # diploid species
test <- subset(rate, order =="Hymenoptera")  #Hymenoptera
test <- subset(rate, style =="OHD") # other haplodiploid species

pvalue <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS2_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOSN2_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTRP_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucCRP_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$controlSingle_rate, method="spearman")$p.value
pvalue[[length(pvalue)+1]] <- cor.test(test$mtOXPHOS_rate, test$control_rate, method="spearman")$p.value
pvalue_adjusted <- p.adjust(pvalue, method="holm",n = length(pvalue))
cat(pvalue_adjusted,sep="\n")

est <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOS2_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucOXPHOSN2_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucMTRP_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$nucCRP_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$controlSingle_rate, method="spearman")$estimate
est[[length(est)+1]] <- cor.test(test$mtOXPHOS_rate, test$control_rate, method="spearman")$estimate
cat(est,sep="\n")
