library(ggplot2)
library(viridis)
#if (!requireNamespace("BiocManager", quietly = TRUE)){
#  install.packages("BiocManager")
#}

if (!requireNamespace("ggtree", quietly = TRUE)){
  BiocManager::install("ggtree")
}
library(ggtree)
tree = ggtree::read.tree(file = "tree.nwk")
tree
#make the plot
ggplot(tree) + geom_tree() + geom_tiplab() + theme_tree()

#You can use some familiar ggplot commands and parameters to control the visualization.

ggplot(tree) + geom_tree(color="firebrick", size=0.5, linetype="dotted", layout="roundrect") + geom_tiplab(size=3) + theme_tree()

#root the tree (H. pylori designated as outgroup)
tree_rooted = ape::root(tree, outgroup = "Helicobacter_pylori_AAD07685.1", resolve.root=TRUE)

ggplot(tree_rooted) + geom_tree() + geom_tiplab() + theme_tree()
 
#expanding plot area so labels don't get cut off, using `hexexpand()` function 
ggplot(tree_rooted) + geom_tree() + geom_tiplab() + theme_tree() + hexpand(0.25)

#We can annotate these clades on the tree using geom_hilight and geom_cladelab.

ggplot(tree_rooted) + geom_tree() + geom_tiplab(size=3) +
  theme_tree() + hexpand(0.25) + 
  geom_hilight(node=36, fill="chartreuse4", alpha=.3, type = "gradient", to.bottom=TRUE, extend=1) + 
  geom_hilight(node=44, fill="chartreuse4", alpha=.3, type = "gradient", to.bottom=TRUE, extend=1) + 
  geom_cladelab(node=36, label = "MutS2a", angle=270, hjust = "center", offset=1, offset.text=0.1) + 
  geom_cladelab(node=44, label = "MutS2b", angle=270, hjust = "center", offset=1, offset.text=0.1)

#We can read in additional data related to the proteins encoded by the genes in this tree with the data file (gene_data.txt) 
#This file contains information about annotated protein domains in each species as well as in silico predictions of whether the protein is targeted to plastids in plant cells.

gene_data = read.delim("gene_data.txt")

gene_data[1:5,]

#adding data plot alongside tree

#store the tree
p1 = ggplot(tree_rooted, aes(x,y)) + geom_tree() + geom_tiplab(size=2.5) + hexpand(1.5) + theme_tree()

#add a facet with lines corresponding to the length of each protein with ggtree function `facetplot`

p2 = facet_plot(p1, panel = "Domains", data = gene_data, geom = geom_segment, #geom_segment draws lines, give it coordinates and it will show length of the protein
                mapping = aes(x=0, xend=Seq_Length, y=y, yend=y), size=0.5, color='black')

#add the domains on top of those lines

p3 = facet_plot(p2, panel = "Domains", data = gene_data, geom=geom_segment, 
                aes(x=Domain_Start, xend=Domain_End, y=y, yend=y, col=Domain_Name), size=3) +
  theme(legend.position = "bottom") + 
  scale_color_viridis(discrete = TRUE)

#add another facet with a bar graph showing the probability of plastid targeting
p4 = facet_plot(p3, panel = "Plastid Targeting", data = gene_data, geom=geom_col, 
                aes(x=Plastid_Targeting), orientation = 'y', fill="chartreuse4") + 
  theme(legend.position = "bottom")

p4
