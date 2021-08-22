library(tidyverse)
library(shiny)
library(CodeClanData)
library(shinyWidgets)
library(bslib)
library(shinythemes)
library(lubridate)

source("ggplot/ggplot_app.R")

ui <- fluidPage(
   
    # theme = bs_theme(bootswatch = "united"),
    
    tabsetPanel(
        
        tabPanel(tags$h4("Main Page"),
                 
                 sidebarLayout(
                     
                     sidebarPanel(
                         
                         plotOutput("market_share_plot_platform")
                         
                     ),
                     
                     mainPanel(tags$h1("Top 100 Games by Sales"),
                               
                               tableOutput("table_output_top_100_by_sales")
                               
                     )
                 )
        ),
        
        tabPanel(tags$h4("PS4"),
                 
                 sidebarLayout(
                     
                     sidebarPanel(
                         
                         img(src = "ps4_logo.png", height = 100, width = 100),
                         
                         pickerInput("genre_input",
                                     "Genre",
                                     choices = unique(game_sales$genre),
                                     selected = "Sports",
                                     options = list(`actions-box` = TRUE), multiple = TRUE
                         ),
                         
                         pickerInput("year_input",
                                     "Year",
                                     choices = unique(sort(game_sales$year_of_release)),
                                     selected = "2015",
                                     options = list(`actions-box` = TRUE), multiple = TRUE
                         ),
                         
                         plotOutput("ps4_plot")
                         
                     ),
                     
                     mainPanel(tags$h1("Top User Rated PS4 Games"),
                               
                               tableOutput("table_output_top_ps4_games")
                               
                     )
                 )            
                 
        ),
        
        tabPanel(tags$h4("XBOX ONE"),
                 
                 sidebarLayout(
                     
                     sidebarPanel(
                         
                         img(src = "xbox_logo.png", height = 60, width = 250),
                         
                         selectInput("genre_input_1",
                                     "Genre",
                                     choices = unique(game_sales$genre),
                                     selected = "Sports"
                         ),
                         
                         selectInput("year_input_1",
                                     "Year",
                                     choices = unique(sort(game_sales$year_of_release)),
                                     selected = "2015"
                         ),
                         
                         plotOutput("xbox_plot")
                         
                     ),
                     
                     mainPanel(tags$h1("Top User Rated Xbox One Games"),
                               
                               tableOutput("table_output_top_xbox_games")
                               
                     )
                 )            
                 
        ),        
        
        tabPanel(tags$h4("Wii"),
                 
                 sidebarLayout(
                     
                     sidebarPanel(
                         
                         img(src = "wii_logo.png", height = 100, width = 100),
                         
                     ),
                     
                     mainPanel(tags$h1("Top User Rated Wii Games"),
                               
                               tableOutput("table_output_top_wii_games")
                               
                     )
                 )            
                 
        )
        
    )
)

server <- function(input, output, session) {
        
        # main page table for 100 games by sales
        output$table_output_top_100_by_sales <- renderTable({
            game_sales %>%
                mutate(year_of_release = as.integer(year_of_release),
                       critic_score = as.integer(critic_score)) %>% 
                arrange(desc("Sales")) %>% 
                head(100)
        })
        
        # plot showing sales versus years split by platform
        output$market_share_plot_platform <- renderPlot({
            market_share_plot_platform()
        })
        
        # data table for PS4 games
        output$table_output_top_ps4_games <- renderTable({
            game_sales %>%
                filter(platform == "PS4",
                       genre == input$genre_input,
                       year_of_release == input$year_input) %>% 
                arrange(desc(user_score)) %>% 
                head(100)
        })
        
        # PS4 plot
        output$ps4_plot <- renderPlot({
            plot_platform_game_sales()
        })
        
        # data table for xbox games
        output$table_output_top_xbox_games <- renderTable({
            game_sales %>%
                filter(platform == "Xone",
                       genre == input$genre_input_1,
                       year_of_release == input$year_input_1) %>%
                arrange(desc(user_score)) %>%
                head(100)
        })
        
        # xbox plot
        output$xbox_plot <- renderPlot({
            plot_platform_game_sales()
        })

}

shinyApp(ui, server)


# (year_of_release == input$year_input,
#     genre == input$genre_input,
#     platform == input$platform_input) 

