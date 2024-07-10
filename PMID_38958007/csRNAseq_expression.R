library(tidyverse)
library(ComplexHeatmap)

all.rlog <- read.delim("~/R/all.rlog.part.txt", stringsAsFactors=TRUE)
df1<- as.matrix(all.rlog %>% filter(Annotation == "promoter") %>% select(7:18)
                %>% slice_max(cas9_2.4h,prop = 0.3))

Heatmap(df1, 
        name = "normalized\nexpression", #title of legend
        row_names_gp = gpar(fontsize = 7), # Text size for row names
       # col = c("#ECF8F8","#b5e4e5", "#53537d") ,
        col = c("#ECF8F8","#b5e4e5", "#6ccacc", "#4293be","#53537d", "#212132") ,
        #col = c("#daf1f2","#6ccacc", "#212132") ,
        column_title = "slice_max(cas9_2.4h,prop = 0.3)")

#export as PDF, landscape orientation

