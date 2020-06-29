header <- dashboardHeader()

sidebar <- dashboardSidebar(
    sidebarMenu(

# menu item #1 ----

        menuItem(
            text = "Overview Data",
            tabName = "overview"
        )

# menu item #2 ----

        # menuItem(
        #     text = "Data Source",
        #     tabName = "data"
        # )
    )
)


body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "overview",
            fluidRow(
                column(
                    width = 12,
                    plotlyOutput("balancePlot")
                )
            ),
            fluidRow(
                column(
                    width = 5,
                    selectInput(
                        inputId = "selectCat",
                        label = "Select Category :",
                        choices = unique(bankm$job)
                    )
                )
            ),
            fluidRow(
                column(
                    width = 12,
                    plotlyOutput("durationPlot")
                )
            )
        )
    )
)

dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body
)