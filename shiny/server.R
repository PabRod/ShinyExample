plotBoth <- function(popMean, popSd, sampleMean, sampleSd) {
    x  <- seq(popMean - 3*popSd, popMean + 3*popSd, popSd/200)
    popY <- dnorm(x, popMean, popSd)
    samY <- dnorm(x, sampleMean, sampleSd)
    
    plot(c(popMean - 3*popSd, popMean + 3*popSd), c(0, 1.5), type="n", xlab = "x", ylab= "Probability density")
    lines(x, popY, col = "blue", lwd=2.5)
    lines(x, samY, col="red",lwd=2.5)    
    legend(popMean, 1.5, c("Population", "Sample"), lty=c(1,1), lwd=c(2.5,2.5),col=c("blue", "red"))           
}

shinyServer(
    function(input, output) {   
        popMean <- reactive(input$mean)
        popSd <- reactive(input$sd)

        sample <- reactive(rnorm(input$N, input$mean, input$sd))
        sampleMean <- reactive(mean(sample()))
        sampleSd <- reactive(sqrt(var(sample())))
        
        output$sampleMean <- renderPrint({sampleMean()})
        output$sampleSd <- renderPrint({sampleSd()})
        
        output$plot <- renderPlot(plotBoth(popMean(), popSd(), sampleMean(), sampleSd()))
    }
)