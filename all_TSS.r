#!/usr/bin/env Rscript

#Create file with chr, TSS start, TSS end, gene name, and strand
#Loop through output of bedtools closest, extracting the closest peak for each gene's TSS
#and outputting to a file

#Read through TPM_CD4 csv file and extract list of protein coding genes
#protein_coding <- gene_expr[grep("protein_coding", gene_expr$Additional_annotations),4])
#protein_coding[,2] <- sapply(strsplit(protein_coding[,1], ";"), "[[", 1)

#Read in only protein coding genes from RNA experiment
prot_coding <- read.table("./protein_coding.txt", header = FALSE, stringsAsFactors=FALSE)

#Read in standard information about protein coding gene TSS
TSS <- read.table("./extracted_data.txt", header = TRUE, stringsAsFactors=FALSE)
list_TSS <- data.frame(chr=character(), start=integer(), end=integer(),
    gene=character(), x=character(), strand=character(), stringsAsFactors=FALSE)

#For each protein coding gene, print the chromosome, TSS start, TSS end, gene name,
#and strand information
for(i in 1:nrow(prot_coding)) {
  gene <- prot_coding[i,]
  row <- which(TSS$Gene_Name == gene)[1]
  if(is.na(row)) {
    next
  }
  list_TSS[i,1] = paste("chr", TSS[row,1], sep="")
  if(TSS[row,3] == "+") {
    list_TSS[i, 2] <- TSS[row,4]
    list_TSS[i, 3] <- TSS[row,4] + 5
    list_TSS[i, 6] <- "+"
  }
  else if(TSS[row,3] == "-") {
    list_TSS[i, 2] <- TSS[row,4] - 5
    list_TSS[i, 3] <- TSS[row,4]
    list_TSS[i, 6] <- "-"
  }
  list_TSS[i, 4] <- gene
  list_TSS[i, 5] <- "."
}
list_TSS <- na.omit(list_TSS)
write.table(list_TSS, "./A10_1811_TSS.bed", append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)
