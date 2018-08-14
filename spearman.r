#!/usr/bin/env Rscript

#===============
# Compute spearman correlation between coverage and expression for all donors for each gene,
# outputting to a file with gene, correlation
#===============

merged_cov <- read.table("merged_cov.txt", header=T, row.names=1)
merged_TPM <- read.table("merged_TPM.txt", header=T, row.names=1)

merged_cov <- t(merged_cov)
merged_TPM <- t(merged_TPM)

genes <- colnames(merged_cov)
corrs <- c()

for(i in 1:ncol(merged_cov)){
  corrs[i] <- cor(merged_cov[,i], merged_TPM[,i], method = "spearman")
}

df <- data.frame(genes, corrs)
write.table(df, "./cov_expr_corr.txt", append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)
