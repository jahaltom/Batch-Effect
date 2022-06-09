library(dplyr)

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
group=metadata$Tissue2
batch=metadata$Study
adjusted_counts = sva::ComBat_seq(countData, batch=batch, group=group, full_mod=FALSE)
write.table(adjusted_counts,"CombatSeq.Counts.tsv" ,sep = '\t',quote = FALSE)


