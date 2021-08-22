market_share_plot_platform <- function() {
    game_sales %>%
        filter(year_of_release >= 1996) %>% 
        arrange(desc(sales)) %>% 
        ggplot() +
        aes(x = year_of_release, y = sales, fill = platform) +
        geom_col() +
        labs(
            x = "\nYear of Release",
            y = "Sales (Millions)",
            title = "Game Sales by Platform",
            fill = "Platform"
        ) +
        scale_x_continuous(breaks = c(1996:2016)) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
}

plot_platform_game_sales <- function() {
    
    game_sales %>%
        filter(year_of_release >= 1996) %>% 
        arrange(desc(sales)) %>% 
        ggplot() +
        aes(x = year_of_release, y = sales, fill = genre) +
        geom_col() +
        labs(
            x = "\nYear of Release",
            y = "Sales (Millions)",
            title = "Game Sales by Genre",
            fill = "Genre"
        ) +
        scale_x_continuous(breaks = c(1996:2016)) +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
}

