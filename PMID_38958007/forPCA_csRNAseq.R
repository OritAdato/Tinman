#csRNAseq data
library(tidyverse)
library(DESeq2)

#reading the data
all.rawcounts <- read.delim("~/R/all.rawcounts.part.txt", stringsAsFactors=TRUE)
merged_counts <- all.rawcounts[,c(8:19)]
colData = read.table(file = "colData.txt",header = TRUE, sep = '\t')

#calculating models
dataset <- DESeqDataSetFromMatrix(countData = merged_counts,
                                  colData = colData,
                                  design= ~Strain+Time)
dds <- DESeq(dataset)
rld <- rlog(dds, blind = TRUE) 

#calculate PCA- note the use of ntop!
pcaData <- plotPCA(rld, intgroup = c("Time", "Strain"), 
                   ntop = 40000, returnData=TRUE)

#formatting the data (see vignette)
percentVar <- round(100 * attr(pcaData, "percentVar"))

#plot and export
pdf(file = "PCA.pdf", useDingbats = FALSE)

ggplot(pcaData, aes(PC1, PC2, color=Time, shape=Strain)) +
  geom_point(size=4) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed() +
  theme(axis.text=element_text(size=12))

dev.off()

#auxiliary image- for annotation
plotPCA(rld, intgroup = c("Time"), ntop = 40000) +
  geom_text(aes_string(x = "PC1", y = "PC2", label = "name"), color = "black",position=position_jitter(width=1, height=0.5),size=2.5) 

ggsave("PCA_annotated.png")


  


