library(shiny)
library(tidyverse)
library(shinythemes)

olympics_overall_medals <- read_csv("data/olympics_overall_medals.csv")

all_teams <- unique(olympics_overall_medals$team)

ui <- fluidPage(
    
    tags$h6(titlePanel("Olympic Medals")),
    
    theme = shinytheme("slate"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("nothing_here",
                         "just some radio buttons", 
                         choices = c("TRUE", "FALSE")
            )
        ),
        
        tabsetPanel(
            tabPanel("Plot",
                     plotOutput("medal_plot")
            ), 
            
            tabPanel(tags$i("Which season"),
                     radioButtons("season_input",
                                  "Summer or Winter Olympics?",
                                  choices = c("Summer", "Winter")
                     )
            ), 
            
            tabPanel("Which team?",
                     selectInput("team_input",
                                 "Which Team?",
                                 choices = all_teams
                     )
                     
            ),
            
            tabPanel("???",
                     selectInput("???_input",
                                 "Which ???",
                                 choices = c(1, 2, 3)
                     )
                     
            ),
            
            tabPanel("Link to Olympics site",
                     
                     tags$a("The Olympics website",
                            href = "https://www.olympic.org/")
                     
            )
        )
    )
)
server <- function(input, output) {
    
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team_input) %>%
            filter(season == input$season_input) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col() +
            scale_fill_manual(values = c("brown",
                                         "pink",
                                         "yellow"))
    })
}

shinyApp(ui = ui, server = server)