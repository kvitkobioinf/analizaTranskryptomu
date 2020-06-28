library(DESeq2)
library(ggplot2)
library(ComplexHeatmap)

SRAruns <- c("SRR3191542", "SRR3191543", "SRR3191544", "SRR3191545", "SRR3194428", "SRR3194429", "SRR3194430", "SRR3194431")
SRAitems <- c("Mock1-1", "Mock2-1", "ZIKV1-1", "ZIKV2-1", "Mock1-2", "Mock2-2", "ZIKV1-2", "ZIKV2-2")
SRAdevices <- c(rep("Illumina MiSeq", times = 4), rep("NextSeq 500", times = 4))
SRAshortcuts <- c("M1_MiSeq", "M2_MiSeq", "Z1_MiSeq", "Z2_MiSeq", "M1_NextSeq", "M2_NextSeq", "Z1_NextSeq", "Z2_NextSeq")

SRAdata <- rbind(SRAruns, SRAitems, SRAdevices, SRAshortcuts)
print(SRAdata)

counts <- read.delim("~/projekt/analizaTranskryptomu/projekt/hg19/COUNTS/counts_ALL.txt", comment.char="#")
colnames(counts)[7:14] <- SRAshortcuts

dds <- function(data) {
  countData <- data[,7:14]
  rownames(countData) = data$Geneid
  samples <- names(countData)
  cond_1 <- rep("cond1", 4)
  cond_2 <- rep("cond2", 4)
  condition <- factor(c(cond_1, cond_2))
  condition <- factor(c("m", "m", "z", "z", "m", "m", "z", "z"))
  colData <- data.frame(samples = samples, condition = condition)
  dds <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = ~condition)
  
  return(dds)
}

analyseDE = function(data) {
  dds <- DESeq(data)
  res <- results(dds)
  
  r = res[res$baseMean!=0,]
  r = r[r$log2FoldChange > 1 | r$log2FoldChange < -1,]
  x = !is.na(r$padj)
  r = r[x,]
  r = r[r$padj<0.05,]
  
  print(head(r))
  
  return(dds)
}

DE <- analyseDE(dds(counts))

PCAnalysis <- function(data) {
  gene_data <- data[7:14]
  rownames(gene_data) <- data$Geneid
  
  row_sub <- apply(gene_data, 1, function(row) all(row != 0))
  gene_data <- gene_data[row_sub,]
  gene_data_matrix <- as.matrix(gene_data)
  
  pca <- prcomp(t(gene_data_matrix), scale = T)
  pca.data <- data.frame(Sample = rownames(pca$x), X = pca$x[,1], Y = pca$x[,2])
  pca.var <- pca$sdev^2
  pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
  
  ggplot(data = pca.data, aes(x = X, y = Y, label = Sample)) +
    geom_text() +
    xlab(paste("PC1 - ", pca.var.per[1], "%", sep="")) +
    ylab(paste("PC2 - ", pca.var.per[2], "%", sep="")) +
    theme_bw() +
    ggtitle("PCA Plot")
  
}

PCAnalysis(counts)

normalize <- function(data) {
  log_data <- rlog(data)
  normalized_data<- assay(log_data)
  normalized_data <- as.data.frame(normalized_data)
  
  return(normalized_data)
}

drawHeatmap <- function(data){
  threshold <- 10
  data <- data[
      data$M1_MiSeq > threshold | 
      data$M2_MiSeq > threshold | 
      data$Z1_MiSeq > threshold | 
      data$Z2_MiSeq > threshold | 
      data$M1_NextSeq > threshold | 
      data$M2_NextSeq > threshold |
      data$Z1_NextSeq > threshold |
      data$Z2_NextSeq > threshold
    , ]
  data <- data.frame(data$M1_MiSeq, data$M2_MiSeq, data$M1_NextSeq, data$M2_NextSeq, data$Z1_NextSeq, data$Z2_NextSeq, data$Z1_MiSeq, data$Z2_MiSeq)
  names(data) = c(SRAshortcuts[1], SRAshortcuts[2], SRAshortcuts[5], SRAshortcuts[6], SRAshortcuts[3], SRAshortcuts[4], SRAshortcuts[7], SRAshortcuts[8])
  
  Heatmap(data , cluster_columns = FALSE,
          row_names_side = "left",
          row_dend_sid = "left",
          row_names_gp=gpar(cex = 0.8))
}

drawHeatmap(normalize(dds(counts)))
