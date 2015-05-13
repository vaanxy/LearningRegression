library(shiny)
data(mtcars)

numeric.vars <- names(mtcars)[c(3:7)]
factor.vars <- names(mtcars)[-c(1,3:7)]
shinyUI(pageWithSidebar(
        headerPanel("Learning Regression"),
        sidebarPanel(
                selectInput("regressor1","numeric regressors", numeric.vars),
                selectInput("regressor2","facor regressors", factor.vars),
                checkboxInput("show_mean","Show mean of each group", value = FALSE),
                h3("HOW TO USE"),
                p("This App is trying to help you to build a simple Regression Model in an easier way."),
                p("Choose a numeric variable and a factor variable above, the model coefficients and plot will be given on the right side.")
        ),
        mainPanel(
                h3("Regression Model"),
                tableOutput("coef"),
                plotOutput("regression")
                )
        
        
        ))