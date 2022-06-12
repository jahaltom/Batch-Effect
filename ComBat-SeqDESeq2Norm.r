library(dplyr)
library(DESeq2)

#Read in count data.
countData = read.table("results_Count_gene.filtered.tsv",header=TRUE,sep = '\t',quote="")
#X an Y gene names can be the same. This makes them unique. Row is set to this unique value. 
rownames(countData)= paste(countData$Gene_name,countData$Gene_stable_ID, countData$chr,sep="$")

#Select only columns with count data. 
countData=select(countData,contains(c("COVSUBJ","batch")))
#Round count data.
countData=round(countData,0) 


##ComBat-Seq
metadata = read.table("Metadata.tsv",header=TRUE,sep = '\t')
group=metadata$Tissue
batch=metadata$Study
adjusted_counts = sva::ComBat_seq(countData, batch=batch, group=group, full_mod=FALSE)





##DESeq2
dds= DESeqDataSetFromMatrix(countData=adjusted_counts, colData = data.frame(colnames(adjusted_counts)), design = ~1)
dds = DESeq(dds)
#Get normalized expression data
normCounts=counts(dds, normalized = TRUE)
write.table(normCounts,"ComBat-SeqDESeq2NormCount.tsv" ,sep = '\t',quote = FALSE)



