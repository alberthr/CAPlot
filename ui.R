## ui.R ##
library(shinydashboard)
library(shinyjs)

dashboardPage(#skin = "red",
  dashboardHeader(title = "CA Plot"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("CA Biplot", tabName = "tabCorrespondencias", icon = icon("map-marker")),
      menuItem("Documentation", tabName = "ayuda", icon = icon("info-circle"))
    )
  ),
  
  dashboardBody(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tabItems(

      # TAB MAPA DE CORRESPONDENCIAS
      tabItem(tabName = "tabCorrespondencias",
              fluidRow(
                column(width = 3,
                       box(
                         title = "Load Data", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = FALSE,
                         fileInput('file1', 'Import data file',accept=c(".xls",".xlsx")),
                         downloadButton('downloadCA', 'Download Sample Data')                         
                       ),
                       
                       box(
                         title = "Main Components", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         selectInput("tema", label = NULL, choices = list("Gray Theme" = 1, "Clean Theme" = 2, "White Theme" = 3), selected = 1),
                         selectInput("bolatexto", label = NULL, choices = list("Show Markers and Labels" = 1, "Only Labels" = 2, "Only Markers" = 3), selected = 2),
                         sliderInput("aspecto", label ="Aspect Ratio", min = 1, max = 10, value = 5),
                         checkboxInput("contribucion", label = "Show Contributions", value = FALSE)
                       ),
                       
                       box(
                         title = "Sizes", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         sliderInput("tm_texto", label ="Labels", min = 10, max = 100, value = 50),
                         sliderInput("tm_bola", label ="Markers", min = 10, max = 100, value = 30)
                       ),
                       
                       box(
                         title = "Labels", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         checkboxInput("lineabt", label = "Marker-Label line", value = TRUE),
                         checkboxInput("enetiqueta", label = "Wrap Text", value = FALSE),
                         checkboxInput("relleno", label = "Fill Color", value = FALSE),
                         sliderInput("separacion", label ="Strenght of Separation", min = 1, max = 100, value = 25)
                       ),
                       
                       box(
                         title = "Colors", 
                         width = NULL,
                         status = "primary",
                         solidHeader = TRUE,
                         collapsible = TRUE,
                         collapsed = TRUE,
                         colourInput("col1", "Colors", value = "#D11919", showColour = "background"),
                         colourInput("col2", label=NULL, value = "#676767", showColour = "background")
                       )
                ),
                
                column(width = 9,
                       box(
                         title = "CA Biplot", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         plotOutput("correspondencias", height=500)
                       )
                )
              )
      ),

      tabItem(tabName = "ayuda",
              fluidRow(
                column(width = 12,
                       box(
                         title = "How to use it", 
                         width = NULL,
                         status = "primary", 
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         h3("What it is"),                         
                         p("Make a CA plot is not always simple. Sometimes it's difficult to find the suitable software or the software is expensive. R is a free solution but using it is not simple for begginers. This App helps users to make CA Plots in a very simple and fast way. It just plots the 2 dimensions with more contribution and allows the user to customize the plot to fit their needs or make it in a more fancy way."),
                         h3("Preloaded Data"),
                         p("In case you don't have any data to analyize but you want to see how the App works, this comes with pre-loaded data to play with. This is a data frame containing the frequency of execution of 13 house tasks in the couple which comes with the factoextra R library. You can download a sample xls file with this data in the Load Data section if you have doubts on how to create a file with your data."),
                         h3("How to plug data"),
                         p("If you don't have any data to analyize but you want to see how the App works, this comes with pre-loaded data to play with. In case you decide to plug external data and make your analysis this should be in a Excel file (.xls or .xlsx) with a contingency table with the amount of observations of each combination between cases in files and columns. An example file is available to see the correct way to fill the Excel file."),
                         h3("Customize plot"),
                         p("when customizing the plot you can choose a wide range of options to make it suit your needs. You can choose whether you want to show markers, labels or both. Among the options you choose to customize your plot you have the following:"),
                         p("In Main components, you can choose a theme for the plot. That's only the background for the plot, the default is the typical GGPlot gray color. You can also choose if you want to show Markers, Labels or both. The Aspect Ratio allows you to make your plot wider or narrower if you later want to copy the plot in a presentation. Finally you can chose print next to the Axis the contribution of each dimension."),
                         p("The options in the Size menu are very easy, you just have to define a size for the markers and labels. This values just apply for the shown selection, and do nothing otherwise."),
                         p("In the Labels section you have few options. Marker Label Line joins the markers and labels with a thin line if you chose to show both. Wrap Text and Fill color allow you to customize labels making them look like tags. Strenght of Separation is a useful tool to separate labels in case of having lots of them. This is a common problem when ploting CA that many points share space in the plot, using the library GGRepel we can separate the labels that share space and create a much cleaner plot."),
                         p("The colors menu is very simple, there you choose the colors for your markers and labels."),
                         br()
                       )
                )
              )
      )      
    )
  )
)