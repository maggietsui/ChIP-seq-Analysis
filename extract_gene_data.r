#Extract data from standard human assembly

gene_data <- read.table("Homo_sapiens.GRCh37.75.ProteinCodingGenes.gtf")
extracted_data <- subset(gene_data, select=c("V1", "V13", "V7"))
TSS <- c()

for(i in 1:nrow(extracted_data)) {
  if(extracted_data[i, 3] == "+") {
    TSS[i] <- gene_data[i,4]
  } else if(extracted_data[i, 3] == "-") {
    TSS[i] <- gene_data[i,5]
  }
}
extracted_data <- cbind(extracted_data, TSS)

write.table(extracted_data, file="extracted_data.txt", row.names = FALSE, col.names = c('Chromosome', 'Gene_Name', 'Strand', 'TSS'), sep = "\t", quote=FALSE, append=FALSE)
