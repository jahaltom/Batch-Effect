library(DESeq2)
library(dplyr)

#Read in count data.
countData = read.table("results_Count_gene.filtered.tsv",header=TRUE,sep = '\t',quote="")
#X an Y gene names can be the same. This makes them unique. Row is set to this unique value. 
rownames(countData)= paste(countData$Gene_name,countData$Gene_stable_ID, countData$chr,sep="$")

#Select only columns with count data. 
countData=select(countData,contains(c("COVSUBJ","batch")))
#Round count data.
countData=round(countData,0) 


##DESeq2
dds= DESeqDataSetFromMatrix(countData=countData, colData = data.frame(colnames(countData)), design = ~1)
dds = DESeq(dds)
#Get normalized expression data
normCounts=counts(dds, normalized = TRUE)

#Round count data.
normCounts=round(normCounts,0) 


##ComBat-Seq
metadata = read.table("Metadata.tsv",header=TRUE,sep = '\t')
group=metadata$Covid.Status
batch=metadata$Study
adjusted_counts = sva::ComBat_seq(normCounts, batch=batch, group=group, full_mod=FALSE)
write.table(adjusted_counts,"DESeq2NormCombatSeq.Counts.tsv" ,sep = '\t',quote = FALSE)
