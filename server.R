library(shiny)
suppressMessages(library(shinyjs))
suppressMessages(library(tidyverse))

shinyServer(function(input, output, session) {
  
  
  answers <- reactive({
    reactiveValuesToList(input)
  })
  
  output$cv_text <- renderUI({
    
    req(isTruthy(input$cv_items) || isTruthy(input$cv_com))  # requires input
    
    if(is.null(input$cv_items)){ # if comments added, include those
        HTML("<b>","Threats to construct validity: ", "</b>", paste(input$cv_com))}
    else if(is.null(input$cv_com) | input$cv_com == ""){   
        HTML("<b>","Threats to construct validity: ","</b>", paste(input$cv_items, collapse = '; '))}
    else{
        HTML("<b>","Threats to construct validity: ","</b>", paste(input$cv_items, collapse = '; '), paste("; ", input$cv_com))}
  })
    
  output$sv_text <- renderUI({
    
    req(isTruthy(input$sv_items) || isTruthy(input$sv_com))  # requires input
    
    if(is.null(input$cv_items) &!isTruthy(input$cv_com)){  # if items selected in earlier lists, add line break
      
      if(is.null(input$sv_items)){
        HTML("<b>","Threats to statistical conclusion validity: ", "</b>", paste(" ", input$sv_com))}
      else if(is.null(input$sv_com) | input$sv_com == ""){   
        HTML("<b>","Threats to statistical conclusion validity: ","</b>", paste(input$sv_items, collapse = '; '))}
      else{
        HTML("<b>","Threats to statistical conclusion validity: ","</b>", paste(input$sv_items, collapse = '; '), paste("; ", input$sv_com))}}
    
    else{
      
      if(is.null(input$sv_items)){
        HTML('<br/>', "<b>","Threats to statistical conclusion validity: ", "</b>", paste(" ", input$sv_com))}
      else if(is.null(input$sv_com) | input$sv_com == ""){   
        HTML('<br/>', "<b>","Threats to statistical conclusion validity: ","</b>", paste(input$sv_items, collapse = '; '))}
      else{
        HTML('<br/>', "<b>","Threats to statistical conclusion validity: ","</b>", paste(input$sv_items, collapse = '; '),paste("; ", input$sv_com))}}
  })
  
  output$iv_text <- renderUI({
    
    req(isTruthy(input$iv_items) || isTruthy(input$iv_com))  # requires input
    
    if(is.null(input$sv_items) & is.null(input$cv_items) & !isTruthy(input$sv_com) & !isTruthy(input$cv_com)){
      
      if(is.null(input$iv_items)){
        HTML("<b>","Threats to internal validity: ", "</b>", paste(" ", input$iv_com))}
      else if(is.null(input$iv_com) | input$iv_com == ""){   
        HTML("<b>","Threats to internal validity: ", "</b>", paste(input$iv_items, collapse = '; '))}
      else{
        HTML("<b>","Threats to internal validity: ", "</b>", paste(input$iv_items, collapse = '; '), paste("; ", input$iv_com))}}
    
    else{
      
      if(is.null(input$iv_items)){
        HTML('<br/>',"<b>","Threats to internal validity: ","</b>", paste(" ", input$iv_com)) }
      else if(is.null(input$iv_com) | input$iv_com == ""){   
        HTML('<br/>',"<b>","Threats to internal validity: ","</b>", paste(input$iv_items, collapse = '; '))}
      else{
        HTML('<br/>',"<b>","Threats to internal validity: ","</b>", paste(input$iv_items, collapse = '; '), paste("; ", input$iv_com))}}
  })
  
  output$ev_text <- renderUI({
    
    req(isTruthy(input$ev_items) || isTruthy(input$ev_com))  # requires input
    
    if(is.null(input$sv_items) & is.null(input$cv_items) & is.null(input$iv_items) & !isTruthy(input$sv_com) & !isTruthy(input$cv_com) & !isTruthy(input$iv_com)){
      
      if(is.null(input$ev_items)){
        HTML("<b>","Threats to external validity: ", "</b>", paste(" ", input$ev_com))}
      else if(is.null(input$ev_com) | input$ev_com == ""){   
        HTML("<b>","Threats to external validity: ","</b>", paste(input$ev_items, collapse = '; '))}
      else{
        HTML("<b>","Threats to external validity: ","</b>", paste(input$ev_items, collapse = '; '), paste("; ", input$ev_com))}}
    
    else{
      
      if(is.null(input$ev_items)){
        HTML('<br/>',"<b>","Threats to external validity: ", "</b>", paste(" ", input$ev_com))}
      else if(is.null(input$ev_com) | input$ev_com == ""){   
        HTML('<br/>', "<b>","Threats to external validity: ","</b>", paste(input$ev_items, collapse = '; '))}
      else{
        HTML('<br/>', "<b>","Threats to external validity: ","</b>", paste(input$ev_items, collapse = '; '), paste("; ", input$ev_com))}}
  })

  output$other_text <- renderUI({
    
    req(isTruthy(input$other_com))  # requires input
    
    if(is.null(input$sv_items) & is.null(input$cv_items) & is.null(input$iv_items) & is.null(input$ev_items) & !isTruthy(input$sv_com) & !isTruthy(input$cv_com) & !isTruthy(input$iv_com) & !isTruthy(input$ev_com)){
      
        HTML("<b>","Other threats to  validity: ", "</b>", paste(" ", input$other_com))}
       
    else{
      
      HTML('<br/>',"<b>","Other threats to  validity: ", "</b>", paste(" ", input$other_com))}
  })
  
  
  
  output$none_text <- renderUI({ # if nothing is selected
    if(is.null(input$sv_items) & is.null(input$cv_items) & is.null(input$iv_items) & is.null(input$ev_items) & !isTruthy(input$sv_com) & !isTruthy(input$cv_com) & !isTruthy(input$iv_com) & !isTruthy(input$ev_com) & !isTruthy(input$other_com)){
      HTML("<b>","None so far!","</b>", " To identify and add potential validity threats to your report, click on the ", "<em><b>", "Identify Threats ",  "</em></b>", "page")}
  })
  
  observeEvent(input$reset_rate, {
    reset_buttons <- c("cv_rating", "sv_rating", "iv_rating", "ev_rating")
    walk(reset_buttons, ~quick_updateRadioButtons(.x, session = session))
  })
  
  observeEvent(input$about_val, {
    updateTabItems(session, "tabs", "validity_review")
  })
 

## download the report ----
  output$report <- downloadHandler(
    
    
    filename = function() {
      save.as <- ifelse(input$save.as == "word", "doc", 
                 ifelse(input$save.as == "html", "html",
                 ifelse(input$save.as == "md", "md",
                        input$save.as)))

      paste("validity_report", save.as, sep = ".")
    },
    
    content = function(file) {
      
      RmdFile <- composeRmd(answers = isolate(answers()))
      writeLines(RmdFile)
      
      tempReport <- file.path(tempdir(), "report.Rmd")
      writeLines(RmdFile, con = tempReport)
      
      rmarkdown::render(tempReport, output_file = file,
                        envir = new.env(parent = globalenv()))
      
    }
   
  )
 # browser()
}) 

