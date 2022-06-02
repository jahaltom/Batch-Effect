# Batch-Effect


MergeData.py to merge datasets

Tissue_Filter.py: This takes output from MergeData.py and filters the genes by tissue. The TPM is filtered by removing genes where the median < 1. EB genes were removed where the median TPM is less than that of the median of the medians of all known protein coding genes. The same genes are removed from counts as well. A tab delimited file called "List.tsv" is also needed. This script also outputs a file that contains all the genes that passed the TPM filter for any tissue and the corresponding counts as well. Outputs median of known protein coding and lincRNA, and Evidence based genes.


```

```
