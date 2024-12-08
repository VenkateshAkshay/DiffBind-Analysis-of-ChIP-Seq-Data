#Step 1
BiocManager::install("DiffBind")
install.packages("dplyr")
install.packages("magrittr")
library(DiffBind)
library(dplyr)
library(magrittr)

#Step 2
setwd  <- "C:/Users/lenovo/OneDrive/Desktop/Fall 2024/Omics/omics"
tmpdir <- "C:/Users/lenovo/OneDrive/Desktop/Fall 2024/Omics/omics"
if(!dir.exists(tmpdir)){
  dir.create(tmpdir, recursive = TRUE)
}

url <- "https://content.cruk.cam.ac.uk/bioinformatics/software/DiffBind/DiffBind_vignette_data.tar.gz"
file <- basename(url)
options(timeout=600)
download.file(url, file.path(tmpdir, file))
untar(file.path(tmpdir, file), exdir = tmpdir)
setwd(file.path(tmpdir, "DiffBind_vignette"))

#Step 3
csv_file_path <- "C:/Users/lenovo/OneDrive/Desktop/Fall 2024/Omics/omics/DiffBind_Vignette/tamoxifen.csv"
tamo <- read.csv(csv_file_path)
tamoxifen <- dba.analyze(csv_file_path)

#Step 4
tamoxifen.DB <- dba.report(tamoxifen)
print(head(tamoxifen.DB))

#Step 5
dba.plotPCA(tamoxifen, DBA_TISSUE, label=DBA_CONDITION)

#Step 6
dba.plotPCA(tamoxifen, contrast=1, label=DBA_TISSUE)

#Step 7
dba.plotVolcano(tamoxifen)

#Step 8
pvals <- dba.plotBox(tamoxifen)
print(pvals)

#Step 9
corvals <- dba.plotHeatmap(tamoxifen)
print(corvals)

#Step 10
tamoxifen <- dba(sampleSheet="C:/Users/lenovo/OneDrive/Desktop/Fall 2024/Omics/omics/DiffBind_Vignette/tamoxifen.csv")%>%
  dba.blacklist() %>%
  dba.count() %>%
  dba.normalize() %>%
  dba.contrast() %>%
  dba.analyze() 
