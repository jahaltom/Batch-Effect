# Batch-Effect


MergeData.py to merge datasets

Tissue_Filter.py: This takes output from MergeData.py and separates TPM and counts by tissue. Additionaly, the TPM is filtered by removing those EB genes where the median < 1. Uses these medians to remove EB genes where median TPM is less than that of the median of all known protein coding genes. The same genes are removed from counts as well. A tab delimited file called "List.tsv" is also needed. This script also outputs a file that contains all the genes that passed the TPM filter for any tissue and the corresponding counts as well. Outputs median of known protein coding and lincRNA, and Evidence based genes.


```
Heart Protein Coding: 0.8260095 lincRNA: 0.0 Evidence based: 1.3799204999999999
Kidney Protein Coding: 1.0933570000000001 lincRNA: 0.0 Evidence based: 1.3056135
Liver Protein Coding: 0.5885215 lincRNA: 0.0 Evidence based: 1.4257825
Lung Protein Coding: 0.390656 lincRNA: 0.0 Evidence based: 1.5194100000000001
LymphNode Protein Coding: 1.5934154999999999 lincRNA: 0.0 Evidence based: 1.51089
NasalSwab Protein Coding: 2.767021 lincRNA: 0.0 Evidence based: 1.7275575
```
