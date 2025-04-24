library(shiny)
library(quarto)

ui <- fluidPage(
  downloadButton("download_report", "Download report")
)

server <- function(input, output, session) {
  output$download_report <- downloadHandler(
    
    filename =  "Important report.pdf",
    
    content = function(file) {
    
        quarto::quarto_render(
          input = "important_report.qmd"
        )
      
        # copy the quarto generated file to "file" argument.
        # On local machine, the .pdf file is rendered in the same folder as the .qmd file. 
        # The copy.file causes the .pdf to copy into the downloads folder.
        # This might work a bit differently when on the posit server if the 
        # generated filename/location is different??
        generated_file_name <- "important_report.pdf"
        file.copy(generated_file_name, file)
      }
    )
}

shinyApp(ui, server)