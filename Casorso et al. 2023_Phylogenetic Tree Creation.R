#Casorso et al. 2023 - Code for Creating Phylogenetic Tree

library(V.PhyloMaker)

#Step 1: Import species list (read data file into a dataframe)
df <- read.table(file = 'C:\\Users\\Casorso\\Desktop\\Casorso et al. 2023 - Species List for Phylogenetic Tree.txt', header=TRUE, blank.lines.skip = FALSE)
print(df)

#Step 2: Generate phylogeny (this creates a Newick file in your working directory folder; make sure to set your working directory to the appropriate place)
setwd("C:/Users/Casorso/Desktop")
tree <- phylo.maker(sp.list = df, tree = GBOTB.extended) #takes a few minutes

#Step 3: Create Newick string of tree
write.tree(tree$scenario.3, "PhylogeneticTree.nwk") #writes into working directory
write.tree(tree$scenario.3) #prints in R console