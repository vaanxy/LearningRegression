library(shiny)
library(ggplot2)
data(mtcars)


shinyServer(function(input, output){
        ## extract preditor and regressors
        predictor <- mtcars$mpg
        regressor1 <- reactive(mtcars[,input$regressor1])
        regressor2 <- reactive(as.factor(mtcars[,input$regressor2]))
        fit <- reactive(lm(predictor ~ regressor1() + regressor2()))
        output$coef <- renderTable(summary(fit())$coef)
        ## plot
        output$regression <- renderPlot({
                ## draw scatterplot between predictor and regressors
                p <- ggplot(data.frame(predictor, reg1 = regressor1(), reg2 = regressor2()),
                            aes(x =reg1 , y = predictor, colour = reg2))
                p <- p + geom_point(size = 6, shape = "o")
                
                ## draw regressioin line
                p <- p + geom_abline(intercept = fit()$coef[1], slope = fit()$coef[2])
                for (i in 3 : length(fit()$coef)) {
                        p <- p + geom_abline(intercept = fit()$coef[1] + fit()$coef[i], slope = fit()$coef[2])
                }
                for (i in 1 : length(levels(regressor2()))) {
                        ## draw mean line
                        if (input$show_mean) {
                                p <- p + geom_abline(intercept = 
                                                             mean(mtcars$mpg[regressor2() %in% levels(regressor2())[i]]),
                                                     slope = 0,
                                                     linetype = 2)
                        }
                }

                p + xlab(input$regressor1) + ylab("miles per gallon") + labs(colour = input$regressor2) + theme_bw()
        })
})