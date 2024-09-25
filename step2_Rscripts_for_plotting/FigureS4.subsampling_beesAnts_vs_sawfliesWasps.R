library(ggplot2)
library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

# step 1 - plotting
subsample_mtOXPHOS <- read.table("./data/subsampling/set1_mtOXPHOS.subsampling_rates.output", header = T)
head(subsample_mtOXPHOS)

# my_comparisons <- list(c("eu", "an"))
subsample_mtOXPHOS$style <- factor(subsample_mtOXPHOS$style, levels=c("eu", "an"))

(p1 <- ggplot(subsample_mtOXPHOS, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("mtOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# nucOXPHOS
subsample_nucOXPHOS <- read.table("./data/subsampling/set2_nucOXPHOS.subsampling_rates.output", header = T)

head(subsample_nucOXPHOS)

my_comparisons <- list(c("eu", "an"))
subsample_nucOXPHOS$style <- factor(subsample_nucOXPHOS$style, levels=c("eu", "an"))

(p2 <- ggplot(subsample_nucOXPHOS, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucOXPHOS") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# 3 - nucMTRP
subsample_nucMTRP <- read.table("./data/subsampling/set3_nucMTRP.subsampling_rates.output", header = T)
head(subsample_nucMTRP)

# my_comparisons <- list(c("eu", "an"))
subsample_nucMTRP$style <- factor(subsample_nucMTRP$style, levels=c("eu", "an"))

(p3 <- ggplot(subsample_nucMTRP, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucMTRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# 4 - nucCRP
subsample_nucCRP <- read.table("./data/subsampling/set4_nucCRP.subsampling_rates.output", header = T)
head(subsample_nucCRP)

# my_comparisons <- list(c("eu", "an"))
subsample_nucCRP$style <- factor(subsample_nucCRP$style, levels=c("eu", "an"))

(p4 <- ggplot(subsample_nucCRP, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucCRP") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# 5 - nucControlSingle
subsample_nucControlSingle <- read.table("./data/subsampling/set5_nucControlSingle.subsampling_rates.output", header = T)

head(subsample_nucControlSingle)

# my_comparisons <- list(c("eu", "an"))
subsample_nucControlSingle$style <- factor(subsample_nucControlSingle$style, levels=c("eu", "an"))

(p5 <- ggplot(subsample_nucControlSingle, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControlSingle") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# 6 - nucControl
subsample_nucControl <- read.table("./data/subsampling/set6_nucControl.subsampling_rates.output", header = T)

head(subsample_nucControl)

# my_comparisons <- list(c("eu", "an"))
subsample_nucControl$style <- factor(subsample_nucControl$style, levels=c("eu", "an"))

(p6 <- ggplot(subsample_nucControl, aes(x = style, y = rate_my)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill = style), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.006) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControl") + 
    theme(legend.position="none",
          axis.title.x=element_blank(), 
        #axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE) + 
  scale_color_manual(values = c("an" = "#00798c", # green
                                "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("an" = "#00798c", # green
                               "eu" = "#00BA38", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

library(cowplot)
pdf("FigureS4.subsampling_beesAnts_vs_sawfliesWasps.pdf", width = 13, height = 8, useDingbats = FALSE) # Open a new pdf file
plot_grid(p1, p2, p3, p4, p5, p6, ncol = 3,  hjust = -1, vjust = -1)
dev.off() # Close the file

# step 2 - Kruskal Wallis tests
library(pgirmess)

# tip2root$style <- as.factor(tip2root$style)
kruskal.test(rate_my ~ style, data=subsample_mtOXPHOS)
kruskal.test(rate_my ~ style, data=subsample_nucOXPHOS)
kruskal.test(rate_my ~ style, data=subsample_nucMTRP)
kruskal.test(rate_my ~ style, data=subsample_nucCRP)
kruskal.test(rate_my ~ style, data=subsample_nucControlSingle)
kruskal.test(rate_my ~ style, data=subsample_nucControl)
