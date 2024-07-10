library(tidyverse)
library(reshape2)
library(ggplot2)

GOdata <- read.delim("forGO_visualize.txt")

#set clusters as factor
GOdata$cluster <- factor(GOdata$cluster, c("c920","c193","c19","c977"))
#set levels
temp <- levels(GOdata$cluster)

#logPvalue
GOdata$log.pVal <- log10(GOdata$Pvalue)

#plot and save
for (c in 1:length(temp)) {
  clustern <- temp[c]
  dplot <- filter(GOdata, cluster == clustern)
  dplot$Term <- fct_rev(factor(dplot$Term, levels = dplot$Term))
  
  #plot
  ggplot(dplot, aes(x = Term, y = enrichment, fill = log.pVal)) +
    geom_col() + coord_flip( ylim = c(0, 6)) + 
    scale_fill_gradientn(colours = c("grey10", "grey30", "grey80"), limits =  c(-40,-3)) +
    #scale_fill_gradient(low = "#56B1F7",high = "#132B43", limits =  c(-40,-3)) +
    theme_classic() +ggtitle(paste0(clustern)) +
    theme(axis.text.x = element_text(size = 16, colour = "black"))      
  ggsave(paste0(clustern, ".pdf")) #for final export
  #ggsave(paste0(clustern, ".png")) #for fast browsing between files
  
}



