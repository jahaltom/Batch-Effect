import pandas as pd



nasal_counts = pd.read_csv("results_Count_gene.nasal.tsv",sep='\t')
nasal_TPM = pd.read_csv("results_TPM_gene.nasal.tsv",sep='\t')
autopsy_counts = pd.read_csv("results_Count_gene.autopsy.tsv",sep='\t')
autopsy_TPM = pd.read_csv("results_TPM_gene.autopsy.tsv",sep='\t')

#Get autopsy columns names only
autopsyColsCounts = autopsy_counts.columns.difference(nasal_counts.columns)
autopsyColsTPM = autopsy_TPM.columns.difference(nasal_TPM.columns)

#Merge nasal with autopsy
NasalAutopsyCount=pd.merge(nasal_counts, autopsy_counts[autopsyColsCounts], left_index=True, right_index=True, how='outer')
NasalAutopsyTPM=pd.merge(nasal_TPM, autopsy_TPM[autopsyColsTPM], left_index=True, right_index=True, how='outer')

NasalAutopsyCount.to_csv("NasalAutopsyCount",mode='w', sep='\t',header=True,index=False)
NasalAutopsyTPM.to_csv("NasalAutopsyTPM",mode='w', sep='\t',header=True,index=False)
