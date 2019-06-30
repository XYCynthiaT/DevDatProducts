#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

var <- names(diamonds)[-7]
var <- c("None", var)
# Define UI for application that draws a scatter plot
shinyUI(
        fluidPage(
                titlePanel("Diamond Price Plotter"),
                sidebarLayout(
                        sidebarPanel(
                                h3("It may take some time to generate the plot because of the large data size."),
                                sliderInput("p", "Sample size", min = 0.6, max = 0.8,
                                            value = 0.6, step = 0.01),
                                selectInput("x", "X-axis", choices = var, 
                                            selected = var[2]),
                                sliderInput("alpha", "Transparency", min = 0, max = 1, 
                                            value = 0.1, step = 0.05),
                                selectInput("col", "Color", choices = var, 
                                            selected = var[1]),
                                selectInput("frow", "Facet Row (factor variables only)", choices = var[c(1, 3:5)], 
                                            selected = var[1]),
                                selectInput("fcol", "Facet Column (factor variables only)", choices = var[c(1, 3:5)], 
                                            selected = var[1]),
                                selectInput("ele", "Add Boxplot/Line/None", 
                                            choices = c("Boxplot", "Line", "None"),
                                            selected = "None"),
                                submitButton("Go"),
                                h3("Info of Diamonds Dataset"),
                                helpText("A dataset containing the prices and other attributes of almost 54,000 diamonds. The variables are as follows:"),
                                p("price: \n price in US dollars ($326-$18,823)"),
                                p("carat: \n weight of the diamond (0.2-5.01)"),
                                p("cut: \n quality of the cut (Fair, Good, Very Good, Premium, Ideal)"),
                                p("color: \n diamond colour, from J (worst) to D (best)"),
                                p("clarity: \n a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))"),
                                p("x: \n length in mm (0-10.74)"),
                                p("y: \n width in mm (0-58.9)"),
                                p("z: \n depth in mm (0-31.8)"),
                                p("depth: \n total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43-79)"),
                                p("table: \n width of top of diamond relative to widest point (43-95)")
                        ),
                        mainPanel(
                                h1("The plot"),
                                plotOutput("plot", height = "800px" ),
                                h3("Documentation"),
                                p("The Diamond Price Plotter is a tool used to plot the relationship between diamond price and other variables."),
                                p("Users can customize the sample size, x-axis, transparency and color of the points. The default plot type is a scatter plot."),
                                p("Furthermore, users can display a linear regression line or boxplot and use facet to plot multiple plots in rows and columns."),
                                p("Once variables changed, click \"Go\" to generate a new plot."),
                                p("Created as part of the coursera course << Developing Data Products >>")
                        )
                )
        )
)
