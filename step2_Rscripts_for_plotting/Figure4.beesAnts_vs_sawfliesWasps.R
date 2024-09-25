library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

tip2root <- read.table("./data/evolutionary_rate.root2tip.table")

tip2root_euAn <- subset(tip2root, style3 == "HD" | style3 == "HD_an")
tip2root_euAn$style3 <- factor(tip2root_euAn$style3, levels=c("HD", "HD_an"))

#tip2root$style <- factor(tip2root$style, levels=c("HD", "HD_an", "OHD", "D"))

my_comparisons <- list(c("HD", "HD_an"))

(p1 <- ggplot(tip2root_euAn, aes(x = style3, y = mtOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("mtOXPHOS") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # dark green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

(p2 <- ggplot(tip2root_euAn, aes(x = style3, y = nucOXPHOS_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucOXPHOS") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

(p3 <- ggplot(tip2root_euAn, aes(x = style3, y = nucMTRP_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucMTRP") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

(p4 <- ggplot(tip2root_euAn, aes(x = style3, y = nucCRP_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucCRP") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

(p5 <- ggplot(tip2root_euAn, aes(x = style3, y = controlSingle_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControlSingle") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

(p6 <- ggplot(tip2root_euAn, aes(x = style3, y = control_rate)) + 
    geom_violin(draw_quantiles = c(0.5), aes(fill=style3), alpha = 0.5, scale = "width") + 
    geom_jitter(aes(color = style3), position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("nucControl") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) +
  scale_color_manual(values = c("HD" = "#00BA38", # green
                                "HD_an" = "#00798c", # green
                                "OHD" = "#619CFF", # grey
                                "D" = "#F8766D")) + # red
  scale_fill_manual(values = c("HD" = "#00BA38", # green
                               "HD_an" = "#00798c", # green
                               "OHD" = "#619CFF", # grey
                                 "D" = "#F8766D")) 
  )

# arrange plots
library(cowplot)
pdf("Figure4.beesAnts_vs_sawfliesWasps.pdf", width = 13, height = 7, useDingbats = FALSE) # Open a new pdf file
plot_grid(p1, p2, p3, p4, p5, p6, ncol = 3,  hjust = -1, vjust = -1)
dev.off() # Close the file

# Kruskal Wallis tests (bees and ants) vs (sawflies and wasps)
library(pgirmess)

tip2root_euAn$style <- as.factor(tip2root_euAn$style)

kruskal.test(mtOXPHOS_rate ~ style3, data=tip2root_euAn)
kruskal.test(nucOXPHOS_rate ~ style3, data=tip2root_euAn)
kruskal.test(nucMTRP_rate ~ style3, data=tip2root_euAn)
