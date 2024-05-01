plot.new()
polygon(c(0, 0, 0.4, 0.4), c(0, 0.8, 0.8, 0))
plot.new()
#order of points is important
#first point is (x,y) of first point, and then next is (x,y) of end point
segments (0.3, 0.2, 0.8, 0.2, col="steelblue", lwd=2)
#made a straight line :)

#making gene map
#need to read in the files so we can import into the drawing
gene_map = read.delim("gene_map.txt")
contig_lengths=read.delim("contig_lengths.txt")
plot.new()

#need to do line first, so they are the base and stuff is put on top
#set starting x at zero
#divide everything by the largest number to scale it
#need to separate things so they aren't on top of each other, define y coordinate space with contig numbers


segments(0,1-contig_lengths$Contig[1]/5, contig_lengths$Length[1]/max_length, 1-contig_lengths$Contig[1]/5)

#add polygons on top, with text names
#use loops to do each of the contigs without rewriting all the commands

