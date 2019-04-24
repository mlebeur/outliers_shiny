#Increase size of upload files to 500 Mo
options(shiny.maxRequestSize=500*1024^2)
options(warn=-1)

if (!require("shiny"))
  install.packages("shiny")

if (!require("DT"))
  install.packages("DT")

if (!require("proxy"))
  install.packages("proxy")

if (!require("dbscan"))
  install.packages("dbscan")

if (!require("mlbench"))
  install.packages("mlbench")

if (!require("randomForest"))
  install.packages("randomForest")

if (!require(devtools))
  install.packages("devtools")
  
if (!require("IsolationForest"))
  devtools::install_github("yanyachen/IsolationForest")

if (!require("autoencoder"))
  install.packages("autoencoder")

if (!require("fclust"))
  install.packages("fclust")

if (!require("DMwR"))
  install.packages("DMwR")

if (!require("HighDimOut"))
  install.packages("HighDimOut")

if (!require("robustbase"))
  install.packages("robustbase")

if (!require("SeleMix"))
  install.packages("SeleMix")

if (!require("shinythemes"))
  install.packages("shinythemes")

library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("spacelab"),
                  tags$head(includeScript("googleanalytics.js")),
  navbarPage("2D Outlier Analysis",tabPanel("App",
  sidebarPanel(
         h3("Please choose your input file:"),
      wellPanel(
        fileInput(inputId = "File", label = "Select input file", accept = ".txt"),
        print("The file should contain a header and clustering labels (having the name \"label\" (txt tabulation format)).")
      ),
      wellPanel(
        selectInput('Model',label="Model",choices=list("Hierarchical Clustering"=12,
                                  "Mahalanobis Distance"=2,
                                  "EM - can be slow to converge"=17,
                                  "Kmeans Euclidean Distance" =1, 
                                  "Kmeans Means Distance"=3,
                                  #"Kmeans Minkowski"=4, 
                                  "Fuzzy kmeans"=9,"Fuzzy kmeans - Gustafson and Kessel"=10,"Fuzzy k-medoids"=13,"Fuzzy k-means with polynomial fuzzifier"=11, 
                                  "Local Outlier Factor"=5,
                                 # "SVM"=16,
                                  "RandomForest"=6,"Isolation Forest"=7,
                                  "FBOD"=14,"SOD"=15,
                                  "Autoencoder"=8
                                  ),selected = 1),
      selectInput('sample',label="Sample",choices=list("Random" =1, 
                                  "Corners"=2,"Doughnut"=3,"Smiley"=4,"Spiral"=5,"Eyes"=6,"Butterfly"=7,"Axis-Parallel Subspace"=8,"StarsCYG"=9),selected = 1),
      numericInput('clusters', 'Cluster count/Neighbors', 3,
                 min = 1, max = 9),
      sliderInput("outlierper", "Outlier %:", 
                min = 85, max = 99, value = 90, step= 1), 
      actionButton("button", "Update Sample Data"),
      p(),
      actionButton("scalebutton", "Scale Data")
    )

  ),
  mainPanel(
    plotOutput('plot1',click = "plot_click",
               brush = brushOpts(id = "plot1_brush")),
    DT::dataTableOutput("mytable1") 
  )),
tabPanel("About" ,
         fluidRow(
           column(10,includeMarkdown("docs/introduction.md"))
         )),
tabPanel("Tutorial" ,
         fluidRow(
           column(10,includeMarkdown("docs/tutorial.md"))
         ))

) ))
