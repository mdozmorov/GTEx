library(yarn)
library(dplyr)

data_dir <- "/Users/mdozmorov/Documents/Data/GenomeRunner/GTEx/" # Mac
data_dir <- "F:/Data/GenomeRunner/TCGAsurvival/data" # Windows
data_dir <- "data/" # Windows temporary
fileNameIn <- "gtex.rds"
fileNameOut <- "gtex_normalized.rds"

# obj = downloadGTEx(type = "genes", file = paste0( data_dir, fileNameIn))
obj <- readRDS(file = paste0(data_dir, fileNameIn))

lowSampleSizes = c("Bladder","Cells - Leukemia cell line (CML)","Cervix - Ectocervix","Cervix - Endocervix","Fallopian Tube")
obj = filterSamples(obj,lowSampleSizes,"SMTSD") %>%
  filterMissingGenes

### Normalize using qsmooth
obj = normalizeTissueAware(obj, "SMTSD")

saveRDS(obj, file = paste0(data_dir, fileNameOut))
