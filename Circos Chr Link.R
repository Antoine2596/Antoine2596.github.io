#mettre taux synthénie par chromosome
library(dplyr)
Barbus <- read.table("Fichier/barbus_genes_coord_last.tsv", header=TRUE, sep="\t")
Squalius <- read.table("Fichier/squalius_genes_coord_last.tsv", header=TRUE, sep="\t")
Barbus_Chr <- subset(Barbus, chr == "1")
Squalius_Chr <- subset(Squalius, chr == "2")

Track_Bb_Sc <- merge(Barbus_Chr,Squalius_Chr, by = "gene_name")

#Création d'une palette
my_colors <- c("#5e4fa2","#637939","#f3c3cb","#b7b8b6","#e7d4e8","#c2a5cf"
                      ,"#c6dbef","#d9d9d9","#66c2a5", "#fd8b62", "#8ea0cc",
                      "#e78ac3","#a7da55", "#ffd930","#e3c49f","#f4a582",
                      "#92c5de","#ca0020","#a7f7f7","#238443","#67001f",
                      "#f1b6da","#0571b0","#fdd0a2","#fee391")
                      
#Ajout des couleurs selon le chromosome
for (i in 1:nrow(Track_Bb_Sc)){
  Track_Bb_Sc$color <- my_colors[i]
}





#Renommer les noms de la colonne "chr"
for (i in 1:nrow(Track_Bb_Sc)){
  print(i)
  Track_Bb_Sc$chr.x[Track_Bb_Sc$chr.x == i ] <- paste("Bb_", i, sep="")
  Track_Bb_Sc$chr.y[Track_Bb_Sc$chr.y == i ] <- paste("Sc_", i, sep="")}










MyGenome <- c(Bb_1 = 47791430, 
              Sc_2 = 62276001)

MyGenome <- as.list(MyGenome)

# On créer un titre
Track <- BioCircosTextTrack("MyTextTrack","Barbus barus et Squalius cephalus",
                            x = -0.9,y=-1.4, size = "1.5em")





# Dans ce script, j'ai réaliser un tableau de couleur avec une couleur pour chaque PN, ainsi les liens auront des couleurs en fonction du chromosome de départ
# On créer une boucle qui va chargée les liens une par une afin d'avoir leur couleurs correspondante
for (i in 1:nrow(Track_Bb_Sc)){
  print(i)
  Track <- Track + BioCircosLinkTrack("Synthénie",
                                      Track_Bb_Sc$chr.x[i],
                                      Track_Bb_Sc$start.x[i],
                                      Track_Bb_Sc$end.x[i],
                                      Track_Bb_Sc$chr.y[i],
                                      Track_Bb_Sc$start.y[i],
                                      Track_Bb_Sc$end.y[i],
                                      maxRadius = 1,
                                      displayLabel = FALSE,
                                      color = "grey",
                                      width = 0.1)}


# On définit un objet qui contient une commande pour afficher le circos
Circos <- BioCircos(Track, # Track contenant toutes les pistes et liens
                    genome = MyGenome, #Liste contenant la taille et les noms des chromosomes
                    genomeTicksDisplay = TRUE, # Afficher la graduation
                    genomeLabelDisplay = TRUE, #Afficher le nom des chromosomes
                    genomeFillColor = my_colors,
                    displayGenomeBorder = FALSE, # Ne pas afficher les bordures
                    genomeTicksLen = 4, #Longueur de la graduation
                    genomeTicksScale = 1400000, #Nombre de paires de bases entre chaques graduations
                    genomeTicksTextSize = "0.0em", #Taille des chiffres de la graduation
                    genomeLabelTextSize = "0.8em", #Taille des noms des chromosomes
                    genomeLabelDy = 0, #Position du nom des chromosome par rapport à la piste de référence
)



#Afficher le circos
Circos

