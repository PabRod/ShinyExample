# Auxiliar function used to generate the plot
plotBoth <- function(popMean, popSd, sampleMean, sampleSd) {
    x  <- seq(popMean - 3*popSd, popMean + 3*popSd, popSd/200)
    popY <- dnorm(x, popMean, popSd)
    samY <- dnorm(x, sampleMean, sampleSd)
    
    plot(c(popMean - 3*popSd, popMean + 3*popSd), c(0, 0.75/popSd), type="n", xlab = "x", ylab= "Probability density")
    lines(x, popY, col = "blue", lwd=2.5)
    lines(x, samY, col="red",lwd=2.5)    
    legend(popMean + popSd, 0.75/popSd, c("Population", "Sample"), lty=c(1,1), lwd=c(2.5,2.5),col=c("blue", "red"))           
}

shinyServer(
    function(input, output) {   
        # Store the population's parameters
        popMean <- reactive(input$mean)
        popSd <- reactive(input$sd)
        
        # Sample and store the sample's parameters
        sample <- reactive(rnorm(input$N, input$mean, input$sd))
        sampleMean <- reactive(mean(sample()))
        sampleSd <- reactive(sqrt(var(sample())))
        
        # Print the results
        output$sampleMean <- renderPrint({sampleMean()})
        output$sampleSd <- renderPrint({sampleSd()})
        
        output$plot <- renderPlot(plotBoth(popMean(), popSd(), sampleMean(), sampleSd()))
    }
)