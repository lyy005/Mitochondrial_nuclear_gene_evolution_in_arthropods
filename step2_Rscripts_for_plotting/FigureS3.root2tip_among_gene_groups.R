library(ggpubr) # ref: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

all_rate_order <- read.table("./data/evolutionary_rate.random.root2tip.table")

all_rate_order$style2 <- factor(all_rate_order$style2, levels=c("Hymenoptera", "Other haplodiploids", "Diploids"))
  
my_comparisons <- list(c("Hymenoptera", "Other haplodiploids"), c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids"))

summary(all_rate_order$mtOXPHOS_rate)
summary(all_rate_order$nucOXPHOS_rate)
summary(all_rate_order$nucMTrRNAprotein_rate)
summary(all_rate_order$nucCytosolicrRNAprotein_rate)
summary(all_rate_order$nucControlSingle_rate)
summary(all_rate_order$nucControlRandom_rate)

sd(all_rate_order$mtOXPHOS_rate)
sd(all_rate_order$nucOXPHOS_rate)

# subset columns
library(tidyr)
library(pgirmess)
all_rate_order$mtOXPHOS_rate

all_rate_order_di <- subset(all_rate_order, style2 == "Diploids")
all_rate_order_hym <- subset(all_rate_order, style2 == "Hymenoptera")
all_rate_order_hd <- subset(all_rate_order, style2 == "Other haplodiploids")

# diploids
test <- all_rate_order_di[,c("spp", "mtOXPHOS_rate","nucOXPHOS_rate","nucMTrRNAprotein_rate",
                          "nucCytosolicrRNAprotein_rate","nucControlSingle_rate","nucControlRandom_rate")]
# hymenopterans
test <- all_rate_order_hym[,c("spp", "mtOXPHOS_rate","nucOXPHOS_rate","nucMTRP_rate",
                          "nucCRP_rate","controlSingle_rate","control_rate")]

# other haplodiploids
test <- all_rate_order_hd[,c("spp", "mtOXPHOS_rate","nucOXPHOS_rate","nucMTRP_rate",
                          "nucCRP_rate","controlSingle_rate","control_rate")]

# all species
test <- all_rate_order[,c("spp", "mtOXPHOS_rate","nucOXPHOS_rate","nucMTRP_rate",
                          "nucCRP_rate","controlSingle_rate","control_rate")]

test_long <- test %>% 
  pivot_longer(
    cols = `mtOXPHOS_rate`:`control_rate`, 
    names_to = "genes",
    values_to = "rate"
)

head(test_long)


kruskal.test(rate ~ genes, data = test_long)
kruskalmc(test_long$rate, test_long$genes, probs = 0.05)


## sig. tests to letter notations
#install.packages("multcompView")
library(multcompView)
# example
dif3 <- c(FALSE, FALSE, TRUE)
names(dif3) <- c("A-B", "A-C", "B-C")
dif3L <- multcompLetters(dif3)

dif3L
print(dif3L)
print(dif3L, TRUE)

kw <- kruskalmc(test_long$rate, test_long$genes, probs = 0.05)
kw_multi <- kw$dif.com[,3]

names(kw_multi) <- row.names(kw$dif.com)
kw_multi

multcompLetters(kw_multi)


# step 2 - plotting
library(tidyverse)
all_rate_order_long <- as_tibble(as.data.frame(all_rate_order)) %>% 
  select(spp, mtOXPHOS_rate, nucOXPHOS_rate, nucMTRP_rate, 
                      nucCRP_rate, controlSingle_rate, control_rate) %>%
  gather(key = "gene", value = "rate", c(-spp))

# all species
all_rate_order_long$gene <- factor(all_rate_order_long$gene, levels=c("mtOXPHOS_rate", "nucOXPHOS_rate", "nucMTRP_rate", 
                                                "nucCRP_rate", "controlSingle_rate",
                                                "control_rate"))

(S1p0 <- ggplot(all_rate_order_long, aes(x = gene, y = rate)) + 
    geom_violin(fill = "black", draw_quantiles = c(0.5), alpha = 0.5, scale = "width") + 
    geom_jitter(color = "black", position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.007) + 
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Diploids") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18))
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)

  )


# by orders
hym <- all_rate_order[all_rate_order$style2 == "Hymenoptera", ]
hd <- all_rate_order[all_rate_order$style2 == "Other haplodiploids", ]
d <- all_rate_order[all_rate_order$style2 == "Diploids", ]

hym_long <- as_tibble(as.data.frame(hym)) %>% 
  select(spp, mtOXPHOS_rate, nucOXPHOS_rate, nucMTRP_rate, 
                      nucCRP_rate, controlSingle_rate, control_rate) %>%
  gather(key = "gene", value = "rate", c(-spp))

hym_long$gene <- factor(hym_long$gene, levels=c("mtOXPHOS_rate", "nucOXPHOS_rate", "nucMTRP_rate", 
                                                "nucCRP_rate", "controlSingle_rate",
                                                "control_rate"))
# hymenopterans
(S1p1 <- ggplot(hym_long, aes(x = gene, y = rate)) + 
    geom_violin(fill = "#00BA38", draw_quantiles = c(0.5), alpha = 0.5, scale = "width") + 
    geom_jitter(color = "#00BA38", position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.004) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Hymenoptera") +
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18))
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  )

# other haplodiploid species
hd_long <- as_tibble(as.data.frame(hd)) %>% 
  select(spp, mtOXPHOS_rate, nucOXPHOS_rate, nucMTRP_rate, 
                      nucCRP_rate, controlSingle_rate, control_rate) %>%
  gather(key = "gene", value = "rate", c(-spp))

hd_long$gene <- factor(hd_long$gene, levels=c("mtOXPHOS_rate", "nucOXPHOS_rate", "nucMTRP_rate", 
                                                "nucCRP_rate", "controlSingle_rate",
                                                "control_rate"))

(S1p2 <- ggplot(hd_long, aes(x = gene, y = rate)) + 
    geom_violin(fill = "#619CFF", draw_quantiles = c(0.5), alpha = 0.5, scale = "width") + 
    geom_jitter(color = "#619CFF", position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.007) +
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Other haplodiploid") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) 
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)
  )

# diploid species
d_long <- as_tibble(as.data.frame(d)) %>% 
  select(spp, mtOXPHOS_rate, nucOXPHOS_rate, nucMTRP_rate, 
                      nucCRP_rate, controlSingle_rate, control_rate) %>%
  gather(key = "gene", value = "rate", c(-spp))

d_long$gene <- factor(d_long$gene, levels=c("mtOXPHOS_rate", "nucOXPHOS_rate", "nucMTRP_rate", 
                                                "nucCRP_rate", "controlSingle_rate",
                                                "control_rate"))

(S1p3 <- ggplot(d_long, aes(x = gene, y = rate)) + 
    geom_violin(fill = "#F8766D", draw_quantiles = c(0.5), alpha = 0.5, scale = "width") + 
    geom_jitter(color = "#F8766D", position=position_jitter(width = 0.4, height = 0)) + 
    ylim(0, 0.003) + 
    theme_bw() + ylab("Evoluationary rates") + ggtitle("Diploids") + 
    theme(legend.position="none",axis.title.x=element_blank(), 
        axis.text.x=element_blank(), panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),axis.title.y = element_text(size = 18),
        plot.title = element_text(hjust = 0.5, size = 18)) 
  #stat_compare_means(comparisons = list(c("Hymenoptera", "Diploids"), c("Other haplodiploids", "Diploids")),label = "p.signif")
  #stat_compare_means(comparisons =my_comparisons,label = "p.signif", hide.ns = TRUE)

  )

# arrange plots
library(cowplot)
pdf("FigureS3.root2tip_among_gene_groups.pdf", width = 13, height = 12, useDingbats = FALSE) # Open a new pdf file
plot_grid(S1p0, S1p1, S1p2, S1p3, ncol = 1,  hjust = -1, vjust = -1)
dev.off() # Close the file
