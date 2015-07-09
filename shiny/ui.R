shinyUI(
    pageWithSidebar(
        # Application title
        headerPanel("Inference simulation"),
        sidebarPanel(
            numericInput('mean', 'Mean of the population', 0, min = -5, max = 5, step = 0.1),
            numericInput('sd', 'Standard deviation of the population', 1, min = 0.1, max = 5, step = 0.1),
            h4('Larger samples must led to better inference. Give it a try.'),
            sliderInput('N', 'Sample size', 10, min = 2, max = 100, step = 1),
            submitButton('Sample!')
        ),
        mainPanel(
            h3('Comparing inferred and exact distributions'),
            h4('Inferred mean'),
            verbatimTextOutput("sampleMean"),
            h4('Inferred standard deviation'),
            verbatimTextOutput("sampleSd"),
            plotOutput('plot'),
            h5('By Pablo Rodríguez. July 2015')
        )
    )
)