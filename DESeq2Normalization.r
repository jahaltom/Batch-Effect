library(DESeq2)
library(dplyr)

#Read in count data.
countData = read.table("results_Count_gene.filtered.tsv",header=TRUE,sep = '\t')
#X an Y gene names can be the same. This makes them unique. Row is set to this unique value. 
rownames(countData)= paste(countData$Gene_name,countData$Gene_stable_ID, countData$chr,sep="$")

#Select only columns with count data. 
countData=select(countData,contains(c("COVSUBJ","batch")))
#Round expression data.
countData=round(countData,0) 

#Read in expermental design
metadata = read.table("Metadata.tsv",header=TRUE,row.names=1,sep = '\t')

#Should return TRUE
#all(rownames(metadata) == colnames(countData))
 
#Make DEseq2 object
dds = DESeqDataSetFromMatrix(countData = countData,colData = metadata,design = ~ Study)
dds = DESeq(dds)
#Get normalized expression data
normCounts=counts(dds, normalized = TRUE)
write.table(normCounts,"DESeq_Count.tsv" ,sep = '\t',quote = FALSE)
