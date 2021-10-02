source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly");
libraryRequireInstall("networkD3");
libraryRequireInstall("htmltools");
libraryRequireInstall("dplyr");
libraryRequireInstall("igraph")
####################################################

################### Actual code ####################
dataset <- Values

names_selected <- unique(dataset$node)

dataset_1 <- dataset[dataset$source_name %in% names_selected, ]
dataset_2 <- dataset[dataset$target_name %in% names_selected, ]
dataset <- rbind(dataset_1, dataset_2)
dataset <- dataset[order(dataset$source_name), ]
dataset <- unique(dataset[,1:9])

nodes_1 <- unique(dataset[c('target_name', 'target_group', 'target_size')])
nodes_1 <- nodes_1[order(nodes_1$target_name), ]
row.names(nodes_1) <- NULL
colnames(nodes_1) <- c('name', 'group', 'size')

nodes_2 <- unique(dataset[c('source_name', 'source_group', 'source_size')])
nodes_2 <- nodes_2[order(nodes_2$source_name), ]
row.names(nodes_2) <- NULL
colnames(nodes_2) <- c('name', 'group', 'size')

nodes <- unique(rbind(nodes_1, nodes_2))
nodes <- nodes[order(nodes$name), ]

dicitonary <- data.frame(nodes$name, seq(0, nrow(nodes)-1))
colnames(dicitonary) <-  c("Nomes", "ID")
source_values <- c()
target_values <- c()

if (length(names_selected) < 10) {
  gravity <- -2000
} else {
  gravity <- -400
}

for (i in dataset$source_name) {
  source_values <- c(source_values, dicitonary[dicitonary$Nomes == i, ]$ID)
}

for (j in dataset$target_name) {
  target_values <- c(target_values, dicitonary[dicitonary$Nomes == j, ]$ID)
}

dataset$source <- source_values
dataset$target <- target_values

links <- dataset[c('source', 'target', 'value')]

p <- forceNetwork(Links = links, 
                  Nodes = nodes, 
                  Source = 'source', 
                  Target = 'target', 
                  NodeID = 'name',
                  Group = 'group', 
                  Value = "value",
                  Nodesize = 'size',
                  radiusCalculation = JS("d.nodesize"),
                  zoom = TRUE, 
                  arrows = TRUE,
                  linkWidth = JS("function(d){return d.value;}"),
                  linkDistance = JS("function(d){return d.value*10}"),
                  charge = gravity,
                  opacity = 0.95,
                  fontSize = 24,
                  linkColour = "#424242"
)

customJS <- 
  "function() { 
    d3.selectAll('.node text').style('fill', 'white').attr('stroke-width', '.1px').attr('stroke', '#3f3f3f');
    d3.select('body').style('background-color', '#15171a');
  }"

g <- htmlwidgets::onRender(p, customJS)
####################################################

############# Create and save widget ###############
internalSaveWidget(g, 'out.html');
####################################################
