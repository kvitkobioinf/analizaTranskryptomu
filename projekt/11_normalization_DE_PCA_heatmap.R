library(DESeq2)
library(ggplot2)
library(ComplexHeatmap)

counts <- read.delim("~/projekt/analizaTranskryptomu/projekt/hg19/COUNTS/counts_ALL.txt", comment.char="#")
#colnames(counts)[7:14] <- c("mock28.bam", "mock29.bam", "mock42.bam", "mock43.bam", "zika30.bam", "zika31.bam", "zika44.bam", "zika45.bam")
#c("SRR3191542", "SRR3191543", "SRR3191544", "SRR3191545", "SRR3194428", "SRR3194429", "SRR3194430", "SRR3194431")
#c("Mock1-1", "Mock2-1", "ZIKV1-1", "ZIKV2-1", "Mock1-2", "Mock2-2", "ZIKV1-2", "ZIKV2-2")
colnames(counts)[7:14] <- c("mock42.bam", "mock43.bam", "zika44.bam", "zika45.bam", "mock28.bam", "mock29.bam", "zika30.bam", "zika31.bam")
colnames(counts)

dds_creator = function(Data){
  countData <- Data[,7:14]
  rownames(countData) = Data$Geneid
  samples = names(countData)
  cond_1 = rep("cond1", 4)
  cond_2 = rep("cond2", 4)
  condition = factor(c(cond_1, cond_2))
  colData = data.frame(samples = samples, condition= condition)
  dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)
  dss1 <- estimateSizeFactors(dds)
  # print(dss1$sizeFactor)
  
  return(dds)
}

DESeq_func = function(dds){
  dds = DESeq(dds)
  res = results(dds)
  
  #zmienne o wartosci 0
  r = res[res$baseMean!=0,]
  #dane znaczące
  r = r[r$log2FoldChange > 1 | r$log2FoldChange < -1,]
  #usuwanie brakow (NA)
  x = !is.na(r$padj)
  r = r[x,]
  #p - value <0.05
  r = r[r$padj<0.05,]
  print(head(r))
  return(dds)
}


data_for_dds = dds_creator(counts)
dds = DESeq_func(data_for_dds)

normal = function(Data){
  countData <- Data[,7:14]
  rownames(countData) = Data$Geneid
  samples = names(countData)
  cond_1 = rep("cond1", 4)
  cond_2 = rep("cond2", 4)
  condition = factor(c(cond_1, cond_2))
  colData = data.frame(samples = samples, condition= condition)
  dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)
  dss1 <- estimateSizeFactors(dds)
  print(dss1$sizeFactor)
  log_data <- rlog(dds)
  norm_data<- assay(log_data)
  norm_data <- as.data.frame(norm_data)
  
  return(norm_data)
}

my_heat = function(dane){
  expression = 9
  dane = dane[dane$mock28.bam > expression | dane$mock29.bam> expression | dane$zika30.bam > expression | dane$zika31.bam > expression | dane$mock42.bam > expression | dane$mock43.bam > expression| dane$zika44.bam > expression |dane$zika45.bam > expression, ]
  print(dane)
  dane1 = data.frame(dane$mock28.bam, dane$mock29.bam, dane$zika30.bam, dane$zika31.bam, dane$mock42.bam, dane$mock43.bam, dane$zika44.bam, dane$zika45.bam)
  names(dane1) = c("M28", "M29", "Z30", "Z31", "M42", "M43", "Z44", "Z45")
  
  Heatmap(dane1, cluster_columns=FALSE,
          row_names_side = "left",
          row_dend_sid = "left",
          row_names_gp=gpar(cex=0.5))
}
nor = normal(counts)

pca = function(data){
  data1 = data[7:14]
  colnames(data1) <- c("M42", "M43", "Z44", "Z45", "M28", "M29", "Z30", "Z31")
  rownames(data1) = data$Geneid
  
  row_sub = apply(data1, 1, function(row) all(row !=0 ))
  data2 <- data1[row_sub,]
  data2 = as.matrix(data2)
  
  pca <- prcomp(t(data2), scale = T)
  pca.data <- data.frame(Sample=rownames(pca$x),
                         X=pca$x[,1],
                         Y=pca$x[,2])
  
  pca.var <- pca$sdev^2
  pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
  
  ggplot(data=pca.data, aes(x=X, y=Y, label=Sample)) +
    geom_text() +
    xlab(paste("PC1 - ", pca.var.per[1], "%", sep="")) +
    ylab(paste("PC2 - ", pca.var.per[2], "%", sep="")) +
    theme_bw() +
    ggtitle("PCA Plot")
  
}
pca(counts)
my_heat(nor)
