#28.01.20
#annie.herbert@bristol.ac.uk
#Fits all models from 1 to 6 classes
#And reads out diagnostics for these models to a text file

install.packages("MplusAutomation")
library(MplusAutomation)

##################################################################################
createModels("A:Quant/P2 - Profiles/JIPV/final code/victimisation_lca_models.txt")
runModels("A:Quant/P2 - Profiles/JIPV/results/mplus", recursive=TRUE, replaceOutfile="never")
##################################################################################
createModels("A:Quant/P2 - Profiles/JIPV/final code/victimisation_lca_models - blrt.txt")
runModels("A:Quant/P2 - Profiles/JIPV/results/blrt", recursive=TRUE, replaceOutfile="never")
##################################################################################

ipva_vic_models <-  readModels("mplus", what="summaries")

num_models <- 12

tempfornames <- ipva_vic_models[[num_models]]$summaries
names <- names(tempfornames)
names

ipva_vic_summs <- array(dim = c(num_models,length(names)))

for (i in 1:num_models) {
  temp <- ipva_vic_models[[i]]$summaries
  for (j in 1:length(temp)) ipva_vic_summs[i,j] <- temp[1,j]
}
ipva_vic_summs[1,]

colnames(ipva_vic_summs) <- names
ipva_vic_summs

write.table(ipva_vic_summs, file="A:Quant/P2 - Profiles/JIPV/results/ipva_vic_summs.txt", sep = ",", row.names = F)

##################################################################################