
#Création d'une palette
palette <- c("#5e4fa2","#637939","#f3c3cb","#b7b8b6","#e7d4e8","#c2a5cf"
                      ,"#c6dbef","#d9d9d9","#66c2a5", "#fd8b62", "#8ea0cc",
                      "#e78ac3","#a7Dr55", "#ffd930","#e3c49f","#f4a582",
                      "#92c5de","#ca0020","#a7f7f7","#238443","#67001f",
                      "#f1b6Dr","#0571b0","#fdd0a2","#fee391")

my_colors <- rep(palette, length.out = 50)
#Ajout des couleurs selon le chromosome
for (i in 1:25){
  Squalius$color[Squalius$chr == i] <- my_colors[i]
}

gene_Sc_Dr <- merge(Squalius, Danio, by = "gene_name")

# On va faire un tableau dont un prend uniquement les gènes en commun dont les deux chromosomes sont très ressemblants (70% au moins)
# Créer une liste vide pour stocker les valeurs sélectionnées
selected_values <- data.frame()
for (i in 1:25){
  for (l in 1:25){
    if (Matrice_Sc_Dr[l,i]>0.3){
      subset_df <- gene_Sc_Dr[gene_Sc_Dr$chr.x == i & gene_Sc_Dr$chr.y == l, ]
      print("goood")
      selected_values <- rbind(selected_values,subset_df)
    }
  }
  print(i)
}

Link_Sc_Dr <-gene_Sc_Dr
Link_Sc_Dr <- data.frame(selected_values)
#Renommer les noms de la colonne "chr"
for (i in 1:50){
  print(i)
  Link_Sc_Dr$chr.x[Link_Sc_Dr$chr.x == i ] <- paste("Sc_", i, sep="")
  Link_Sc_Dr$chr.y[Link_Sc_Dr$chr.y == i ] <- paste("Dr_", i, sep="")}





#Longueur chromosome Squalius cephalus
library(BioCircos) 
# On créer une liste contenant les noms et longueur des chromosomes avec le Chr 1 de Barbus barbus

Genome__Squalius_Danio <- rbind(Liste_chromosome_Squalius,Liste_chromosome_Danio)

Genome__Squalius_Danio <- setNames(as.double(Genome__Squalius_Danio$Length), Genome__Squalius_Danio$ID)

MyGenome <- as.list(Genome__Squalius_Danio)

# On créer un titre
Track <- BioCircosTextTrack("MyTextTrack","Barbus barus et Squalius cephalus",
                            x = -0.9,y=-1.4, size = "1.5em")

# Drns ce script, j'ai réaliser un tableau de couleur avec une couleur pour chaque PN, ainsi les liens auront des couleurs en fonction du chromosome de départ
# On créer une boucle qui va chargée les liens une par une afin d'avoir leur couleurs corresponDrnte
for (i in 1:nrow(Link_Sc_Dr)){
  print(i)
  Track <- Track + BioCircosLinkTrack("Synthénie",
                                      Link_Sc_Dr$chr.x[i],
                                      Link_Sc_Dr$start.x[i],
                                      Link_Sc_Dr$end.x[i],
                                      Link_Sc_Dr$chr.y[i],
                                      Link_Sc_Dr$start.y[i],
                                      Link_Sc_Dr$end.y[i],
                                      maxRadius = 1,
                                      color = Link_Sc_Dr$color[i],
                                      displayLabel = FALSE,
                                      width = 1)}


# On définit un objet qui contient une commande pour afficher le circos
Circos <- BioCircos(Track, # Track contenant toutes les pistes et liens
                    genome = MyGenome, #Liste contenant la taille et les noms des chromosomes
                    genomeTicksDisplay = TRUE, # Afficher la graduation
                    genomeLabelDisplay = TRUE, #Afficher le nom des chromosomes
                    genomeFillColor = my_colors,
                    displayGenomeBorder = FALSE, # Ne pas afficher les bordures
                    genomeTicksLen = 4, #Longueur de la graduation
                    genomeTicksScale = 140000000, #Nombre de paires de bases entre chaques graduations
                    genomeTicksTextSize = "0.0em", #Taille des chiffres de la graduation
                    genomeLabelTextSize = "0.3em", #Taille des noms des chromosomes
                    genomeLabelDy = 0, #Position du nom des chromosome par rapport à la piste de référence
)



#Afficher le circos
Circos

