#mettre taux synthénie par chromosome
library(dplyr)
Barbus <- read.table("Fichier/barbus_genes_coord_last.tsv", header=TRUE, sep="\t")




#Création d'une palette
palette <- c("#5e4fa2","#637939","#f3c3cb","#b7b8b6","#e7d4e8","#c2a5cf"
                      ,"#c6dbef","#d9d9d9","#66c2a5", "#fd8b62", "#8ea0cc",
                      "#e78ac3","#a7da55", "#ffd930","#e3c49f","#f4a582",
                      "#92c5de","#ca0020","#a7f7f7","#238443","#67001f",
                      "#f1b6da","#0571b0","#fdd0a2","#fee391")
my_colors <- rep(palette, length.out = 75)
#Ajout des couleurs selon le chromosome
for (i in 1:75){
  Barbus$color[Barbus$chr == i] <- my_colors[i]
}


Barbus <- Barbus[,-c(5,6,7,8)]




ensemble1 <- merge(Barbus, Danio, by = "gene_name")


# On va faire un tableau dont un prend uniquement les gènes en commun dont les deux chromosomes sont très ressemblants (70% au moins)
# Créer une liste vide pour stocker les valeurs sélectionnées
selected_values <- data.frame()
for (i in 1:50){
  for (l in 1:25){
    if (Matrice_Bb_Da[l,i]>0.5){
      subset_df <- ensemble1[ensemble1$chr.x == i & ensemble1$chr.y == l, ]
      print("goood")
      selected_values <- rbind(selected_values,subset_df)
      
    }
    
  }
  print(i)
}
#Bbliens <- ensemble1
Bbliens <- data.frame(selected_values)
#Renommer les noms de la colonne "chr"
for (i in 1:50){
  print(i)
  Bbliens$chr.x[Bbliens$chr.x == i ] <- paste("Bb_", i, sep="")
  Bbliens$chr.y[Bbliens$chr.y == i ] <- paste("Da_", i, sep="")}




library(BioCircos) 
# On créer une liste contenant les noms et longueur des chromosomes avec le Chr 1 de Barbus barbus

Genome_Barbus_Danio <- rbind(Liste_chromosome_Barbus,Liste_chromosome_Danio)

Genome_Barbus_Danio <- setNames(as.double(Genome_Barbus_Danio$Length), Genome_Barbus_Danio$ID)

Genome_Barbus_Danio <- as.list(Genome_Barbus_Danio)

# On créer un titre
Track <- BioCircosTextTrack("MyTextTrack","Barbus barus et Danio rerio",
                            x = -0.9,y=-1.4, size = "1.5em")





# Dans ce script, j'ai réaliser un tableau de couleur avec une couleur pour chaque PN, ainsi les liens auront des couleurs en fonction du chromosome de départ
# On créer une boucle qui va chargée les liens une par une afin d'avoir leur couleurs correspondante
for (i in 1:nrow(Bbliens)){
  Avancement <- i/nrow(Bbliens)
  print(Avancement)
  Track <- Track + BioCircosLinkTrack("Synthénie",
                                      Bbliens$chr.x[i],
                                      Bbliens$start.x[i],
                                      Bbliens$end.x[i],
                                      Bbliens$chr.y[i],
                                      Bbliens$start.y[i],
                                      Bbliens$end.y[i],
                                      maxRadius = 1,
                                      color = Bbliens$color[i],
                                      displayLabel = FALSE,
                                      width = 1)}


# On définit un objet qui contient une commande pour afficher le circos
Circos <- BioCircos(Track, # Track contenant toutes les pistes et liens
                    genome = Genome_Barbus_Danio, #Liste contenant la taille et les noms des chromosomes
                    genomeTicksDisplay = TRUE, # Afficher la graduation
                    genomeLabelDisplay = TRUE, #Afficher le nom des chromosomes
                    genomeFillColor = my_colors,
                    displayGenomeBorder = FALSE, # Ne pas afficher les bordures
                    genomeTicksLen = 4, #Longueur de la graduation
                    genomeTicksScale = 140000000, #Nombre de paires de bases entre chaques graduations
                    genomeTicksTextSize = "0.0em", #Taille des chiffres de la graduation
                    genomeLabelTextSize = "0.4em", #Taille des noms des chromosomes
                    genomeLabelDy = 0, #Position du nom des chromosome par rapport à la piste de référence
)



#Afficher le circos
Circos
