library(ggplot2)
library(ggtree)
library(ape)
library(ggrepel)

arthro_tree <- read.nexus("./data/arthropoda3.time.nwk")


( p_tree <- rotate(ggtree(arthro_tree), 77) + 
  #geom_treescale(x = 0.6, y = 50, fontsize=4, linesize=1) + 
  geom_text(aes(label=node)) + 
  #geom_tiplab() + 
  theme_tree2() 
  #scale_x_continuous(breaks=seq(0, 600, 100), labels=abs(seq(-600, 0, 100)))
)

pdf("Figure1.tree.pdf", width = 10, height = 10, useDingbats = FALSE) # Open a new pdf file
p_tree
dev.off() # Close the file
