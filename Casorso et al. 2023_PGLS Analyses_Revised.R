#Casorso et al., 2023 - Code for PGLS Analyses

library(ape)
library(caper)

#Read the data file into a dataframe
df <- read.table(file='C:\\Users\\Casorso\\Desktop\\Casorso et al. 2023 - Ethanol and Dispersal Syndrome.txt', header=TRUE)
#View the dataframe
print(df)

#Phylogenetic tree:
#Tree of adequately-sampled (at least 3 ripe fruits) Costa Rican fruit species, including only those species for which we assigned a specific dispersal syndrome (i.e. bird-dispersed or mammal-dispersed) (n = 30 species), made using V.PhyloMaker in R (node labels removed):
text.string.full <- "(((((Aralia_excelsa:106.741411,((((Randia_monantha:5.771658,Genipa_americana:5.771659):1.094287,Alibertia_edulis:6.865946):21.159177,Guettarda_macrosperma:28.025122):39.70274,Tabernaemontana_odontadeniiflora:67.727863):39.013548):5.599318,Bonellia_nervosa:112.340729):10.240299,(Davilla_kunthii:41.153098,Curatella_americana:41.153098):81.42793):1.153209,(((Vachellia_collinsii:112.701196,((((Ficus_morazaniana:11.922425,Ficus_obtusifolia:11.922426):29.83367,Maclura_tinctoria:41.756095):43.73732,Karwinskia_calderonii:85.493415):25.654592,Quercus_oleoides:111.148008):1.553188):3.084369,(((Casearia_arguta:12.757844,Zuelania_guidonia:12.757845):86.372688,Hirtella_racemosa:99.130532):12.295894,Sloanea_terniflora:111.426427):4.359138):2.793039,(((Carica_papaya:92.953137,(Malvaviscus_arboreus:38.361134,(Guazuma_ulmifolia:32.280668,Apeiba_tibourbou:32.280668):6.080466):54.592003):11.304922,((Trichilia_americana:66.889797,Simarouba_glauca:66.889797):13.028543,(Bursera_simaruba:51.559174,Spondias_mombin:51.559174):28.359167):24.339718):12.735137,Psidium_guajava:116.993196):1.585408):5.155633):12.023828,(Bromelia_pinguin:108.235153,Acrocomia_aculeata:108.235153):27.522912);"
vert.tree <- read.tree(text=text.string.full)
plot.phylo(vert.tree, type = "phylogram", use.edge.length = TRUE, edge.width = 2, root.edge = TRUE)

#Combine phylogeny and data into single object
vert.tree$node.label<-NULL #ignore node labels
EtOHPhylo.object <- comparative.data(phy = vert.tree, data = df, names.col = Species, vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

#Rename variables for ease of models
Disperser <- df$Disperser2.3
MeanEtOH <- df$MeanEtOH.ripe
MaxEtOH <- df$MaxEtOH.ripe


#1) Mean Ethanol (when ripe)
model.pgls.mean <- pgls(MeanEtOH ~ Disperser, data = EtOHPhylo.object, lambda = 'ML')
summary(model.pgls.mean)
#found significant influence of mean ethanol on dispersal syndrome (p < 0.05)
#lambda = 0
#lambda is not significantly different than 0 (p > 0.05), and is significantly different than 1 (p < 0.05) --> consistent with no phylogenetic signal 


#2) Maximum Ethanol (when ripe)
model.pgls.max <- pgls (MaxEtOH ~ Disperser, data = EtOHPhylo.object, lambda = 'ML')
summary(model.pgls.max)
#found significant influence of maximum ethanol on dispersal syndrome (p < 0.05)
#lambda = 0
#lambda is not significantly different than 0 (p > 0.05), and is significantly different than 1 (p < 0.05) --> consistent with no phylogenetic signal