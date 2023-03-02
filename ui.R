# get libraries
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)


dashboardPage(skin = "purple",
              
  dashboardHeader(title = "Seaboat"),
  dashboardSidebar(
    
    sidebarMenu(
      id = "tabs",
      menuItem("Start Here", tabName = "start", icon=icon("hand-o-right")),
      menuItem("Identify Threats", tabName = "threats", icon=icon("dashboard")),
      menuItem("Add Overall Ratings", tabName = "ratings", icon=icon("chart-bar")),
      menuItem("Finish & Download", tabName = "download", icon=icon("cloud-download")),
      menuItem("About the Validities", tabName = "validity_review", icon=icon("book")),
      menuItem("FAQs", tabName = "faqs", icon=icon("info-circle")),
      menuItem("Github Source Code", href="https://github.com/schiavone1/seaboat", icon = icon("github")),
    
    tags$div(
      HTML("<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color: #b8c7ce", "Seaboat:")), '<em>', 
                                                 paste(tags$span(style="color: #b8c7ce", "A boat or vessel adapted")),
           "<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color:#b8c7ce", "to the open sea; hence, a vessel ")),
           "<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color:#b8c7ce", "considered with reference to her ")),
           "<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color:#b8c7ce", "power of resisting a storm, or  ")),
           "<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color:#b8c7ce", "maintaining herself in a heavy sea")), '</em>', 
           "<br>", '&nbsp;', '&nbsp;', '&nbsp;', paste(tags$span(style="color:#b8c7ce", "(Webster & Porter, 1913)"))
           )))
  ),
  
  dashboardBody(
    
    tabItems(
     
    # page: start here ---------------------------
    tabItem(tabName = "start",
            
      h3("Begin Your validity review"),
      
      fluidRow(
        
        box(height = "270px", solidHeader = F, status = "info", title = "About this tool",
          p("This app helps you organize your evaluation of a empirical research, focusing on threats to validity. The app lists common threats to each of four validities. As you’re reading the paper, check off the threats that you think apply. When you’re done, the app will create a report for you to download."),
         div(class = "about_val",  style="text-align: right;",
             actionBttn(
               inputId = "about_val", label = "About the validities", 
               style = "stretch", color = "primary", size = "s"
             ),tags$style(".reset_butt .bttn-primary{color: black;}"))
      ),
        
        box(height="270px", solidHeader = F, status = "danger",
          title = "How to use",
          p(strong("Step 0:"), "Learn about the four validities on the ", strong(em("About the Validities")), " page.",
            style = "margin-top: -10px;"),
          p(strong("Step 1:"), "Begin your report by identifying potential threats to the validity of the research that you are reviewing on the", strong(em("Identify Threats")), " page."),
           # style = "margin-top: -10px;"),
          p(strong("Step 2:"), "Rate the research on each of the four validities on the ", strong(em("Add Overall Ratings")), " page."),
           # style = "margin-top: -2px;"),
          p(strong("Step 3:"), "Add open-ended comments, a title, etc. and download your report on the ", strong(em("Finish & Download")), " page.")
            #style = "margin-top: -2px;")
          ),

      box(width = 12, solidHeader = F, status = "primary",
          title = "Some things to remember",
          p(strong("The lists are not exhaustive!"), "We’ve asked experts to help us identify common threats to each of the four validities, but of course there are many more possible threats. If you see a threat that’s not listed, you can type it in and add it to your report."),
          p(strong("You decide!"),"Just because we list something  as a common threat doesn’t mean it’s always a problem. Use your judgment to decide if a particular issue is a potential threat to validity in the paper you’re evaluating, and only select it if it’s a cause for concern.")
        )
      )
    ),
      
    # page: Identify threats ---------------------------
  
    tabItem(tabName = "threats",
            
      h3("Identify validity threats"),
      helpText("To begin, use the tabs below to review as many of the validities as you want. Identify threats by checking relevant boxes and adding any additional concerns in the comment box. Once you have finished, continue to the ", em(strong("Add Overall Ratings")), "page using the sidebar on the left."
      , style = "color: #404040"),
      
      fluidRow(
      tabBox(title = "", width = 12, 
      
      # sub-page: construct validity ---------------------------
        
        tabPanel(title = tagList(shiny::icon("thumbs-up"), "Construct Validity"), 
                 
          h4("Potential threats to construct validity:", style = "margin-top: 0px; margin-bottom: 17px; font-weight: bold; color: black"),
        
          checkboxGroupInput("cv_items", 
                             label = NULL, choices = construct_list, width = "100%"), 
                             tags$head(tags$style("#checkGroup{color: black}")),
        
          h5("Notes or additional concerns about construct validity:", style = "font-weight: bold; color: black"),

          textAreaInput('cv_com', label = NULL, width = "600px", height = '100px', 
                        placeholder = 'Additional threats to construct validity include...'), tags$head(tags$style("#stat_text{color: black}"))
        ),
        
      # sub-page: statistical validity ---------------------------
        
        tabPanel(title = tagList(shiny::icon("calculator"), "Statistical Validity"),
                 
          h4("Potential threats to statistical conclusion validity:", style = "margin-top: 0px; margin-bottom: 17px; font-weight: bold; color: black"),
          
          checkboxGroupInput("sv_items", 
                             label = NULL,  choices = statistical_list,
                             width = "100%"), tags$head(tags$style("#checkGroup{color: black}")),
        
          h5("Notes or additional concerns about statistical conclusion validity:", style = "font-weight: bold; color: black"),

          textAreaInput('sv_com', 
                        label = NULL, width = "600px", height = '100px',
                        placeholder = 'Additional threats to statistical conclusion validity include...'), tags$head(tags$style("#stat_text{color: black}"))
          ),
        
     # sub-page: internal validity ---------------------------          
        
        tabPanel(title = tagList(shiny::icon("exclamation"), "Internal Validity"),
                    
          h4("Potential threats to internal validity:", style = "margin-top: 0px; margin-bottom: 17px; font-weight: bold; color: black"),
                    
          checkboxGroupInput("iv_items", 
                             label = NULL, choices = internal_list,
                             width = "100%"), tags$head(tags$style("#checkGroup{color: black}")),
         
          h5("Notes or additional concerns about internal validity:", style = "font-weight: bold; color: black"),

          textAreaInput('iv_com',  
                        label = NULL, width = "600px", height = '100px',
                        placeholder = 'Additional threats to internal validity include...'), tags$head(tags$style("#stat_text{color: black}"))
          ), 
        
     # sub-page: external validity ---------------------------  
        
        tabPanel(title = tagList(shiny::icon("robot"), "External Validity"),
                
          h4("Potential threats to external validity:", style = "margin-top: 0px; margin-bottom: 17px; font-weight: bold; color: black"),
        
          checkboxGroupInput("ev_items", 
                             label = NULL, choices = external_list,
                             width = "100%"), tags$head(tags$style("#checkGroup{color: black}")),
        
          h5("Notes or additional concerns about external validity:", style = "font-weight: bold; color: black"),

          textAreaInput('ev_com',  
                        label = NULL, width = "600px", height = '100px',
                        placeholder = 'Additional threats to external validity include...'
                        ), tags$head(tags$style("#stat_text{color: black}"))
          ),
    
     # sub-page: other validity ---------------------------  
    
        tabPanel(title = tagList(shiny::icon("clipboard"), "Other"),
             
             h4("Other potential threats to validity:", style = "margin-top: 0px; margin-bottom: 17px; font-weight: bold; color: black"),
         
             textAreaInput('other_com',  
                           label = NULL, width = "600px", height = '100px',
                           placeholder = 'Additional threats to validity include...'
             ), tags$head(tags$style("#stat_text{color: black}")))))
          ),
    
# page: overall ratings  ---------------------------
    
    tabItem(tabName = "ratings",
            tags$head(
              tags$style(
                HTML(".form-group {
                     margin-bottom: 6px ;}"))
                ),
            
      h3("Add overall ratings of validity"),
            
      fluidRow( 
        
        box(width=6, height= "320px", title = "Evaluating the paper", solidHeader = F, status = "info",
            
            p("The list of threats you identified may or may not capture the overall strengths and limitations of the paper. This is your chance to share your global evaluation of the paper on each validity. All research has limitations. Consider both the strengths and weaknesses of the research when providing an overall rating for each validity. This is, of course, your subjective evaluation.",
              style = "margin-top: -10px;"),
            p("Your overall rating on each validity need not correspond to the number of specific threats identified—any level on the overall rating can in principle be consistent with any number or combination of specific threats.")
           ),
        
        box(width=6, height= "320px", title = "Rate this paper on the four validities:", solidHeader = F, status = "danger",
            p("from 1 (", em("Very low"), ") to 7 (", em("Very High"), ")", style = "margin-bottom: 6px; margin-top: -20px;"),
            
            standard_radioButtons("cv_rating",
                                  "Construct Validity"),
            standard_radioButtons("sv_rating",
                                  "Statistical Conclusion Validity"),
            standard_radioButtons("iv_rating",
                                  "Internal Validity"),
            standard_radioButtons("ev_rating",
                                  "External Validity"),
           div(class = "reset_butt",  style="text-align: right;",
               actionBttn(
                 inputId = "reset_rate", label = "Reset ratings", 
                 style = "stretch", color = "primary", size = "s"
               ),tags$style(".reset_butt .bttn-primary{color: black;}"))
          ),
        
        box(width = 12, solidHeader = F, status = "primary",
            title = "The potential validity threats you identified:",
            uiOutput("cv_text"),
            uiOutput("sv_text"),
            uiOutput("iv_text"),
            uiOutput("ev_text"),
            uiOutput("other_text"),
            uiOutput("none_text")
            ))
      ),
    
# page: download report   ---------------------------
    
    tabItem(tabName = "download",
            
      h3("Finish and download your report"),
      p("Prior to downloading your review report, you may add a title and your name to be included on the downloadable report. 
              This is optional. If you plan to share this report and do not want to sign your review / be identified, do not add your name."),
      
      fluidRow(
         box(width = 12, solidHeader = F, status = "primary",
            title = NULL,
            
            textInput("reporttitle", "Report title:", placeholder = "Review of Article X"),
            textInput("author", "Your name:", placeholder = "Sarah R. Schiavone"),
            textAreaInput('comments',  
                          label = "Additional comments:", height = '200px',
                          placeholder = 'Add any additional comments (e.g., open-ended reviews) to include in your report here.'
            ), tags$head(tags$style("#stat_text{color: black}"))
            ),
        
        box(height="250px",
            title = "File options",
            solidHeader = F,
            status = "success",
            
            p("Your review report can be downloaded in the following formats:"),
            
            tags$ul(
              tags$li("PDF"), 
              tags$li("Word doc"), 
              tags$li("HTML"),
              tags$li("MD")
            )),
        
        box(height = "250px",
            title = "File download", solidHeader = F, status = "danger",
            
            selectInput("save.as", 
                        "Select the file of your choice",
                        choices = c("PDF" = "pdf",
                                    "Word Doc" = "word",
                                    "HTML" = "html",
                                    "MD" = "md")),
            
            br(),
            downloadButton("report", "Download"),
            br(),
            br(),
            p("*this website does save your report or download any of the information you provided."),
            
            uiOutput("save.as")
            )
        )
      ),
    
# page: About the validities   ---------------------------
    
    tabItem(tabName = "validity_review",
            
            h3("About the validities"),

            fluidRow(
              box(width = 12, solidHeader = F, status ="primary", title = NULL,
                  
                  h4( "The four validities", style = "font-weight: bold; color: black; margin-bottom: 5px;"),
                  p("The potential threats to validity in this app are organized around the “four validities” framework popular in the social sciences (Shadish, Cook, and Campbell, 2002), which are described below:"),
                 
                  h5(icon("thumbs-up"), "Construct validity", style = "font-weight: bold; color: black; margin-bottom: 5px; margin-top: 25px;"),
                  p("Construct validity refers to whether the study actually measured and/or manipulated the constructs that the authors wished to study. Construct validity includes the conceptual", strong("match"), "between the construct(s) 
                  and the operationalization(s) made, and the", strong("quality"), "of the measure(s)/manipulation(s). If the match is poor, 
                  construct validity is poor regardless of the quality of the measures.", style = "margin-bottom: -6px;"),
                  br(),
           
                  h5(icon("calculator"),"Statistical validity", style = "font-weight: bold; color: black; margin-bottom: 5px;"),
                  p("Statistical validity refers to the validity of statistical inferences, putting aside any concerns about measurement, conceptual rigor, etc. Inferential statistics require certain assumptions to be met. For example, frequentist statistics (e.g., p-values, confidence intervals) aim to control error rates and are only valid when decisions about data collection and analysis are made a priori, and are not data-dependent. Thus, flexibility in how data are collected and analyzed can pose a serious threat to the validity of many statistical inferences. It is not always obvious whether such flexibility was present (except when the authors share a pre-registered plan). However, there are often signs of flexibility.",
                    style = "margin-bottom: -6px;"),
                  br(),
           
                  h5(icon("exclamation"),"Internal validity", style = "font-weight: bold; color: black; margin-bottom: 5px;"),
                  p("Internal validity refers to whether claims about the causal relationships among variables are warranted by the evidence. To assess internal validity, compare the authors’ claims about causal relationships (if any) with what the study design could reasonably allow with respect to causal claims. Sometimes claims about causality are implied rather than stated explicitly.", 
                    style = "margin-bottom: -6px;"),
                  br(),
                  
                  h5(icon("robot"), "External validity", style = "font-weight: bold; color: black; margin-bottom: 5px;"),
                  p("External validity refers to the validity of generalizations made from the data. This includes generalizations made to other people, other times, other settings (e.g., lab to real world), other stimuli, other measures or manipulations, and other ways of testing the same research question (including everything from other experimenters to other recruitment strategies and more). Few studies can fully justify these kinds of generalizations, yet many such claims are made—whether implicitly or explicitly.", 
                    style = "margin-bottom: -6px;"),
                  br(),
                  br(),
                  h5(icon("book"), "Recommended readings:", style = "font-weight: bold; color: black"),
                  tags$div("Shadish, W. R., Cook, T. D., & Campbell, D. T. (2002). ", tags$i("Experimental and Quasi-experimental Designs for Generalized Causal Inference."), "Houghton Mifflin."),

                  br(),
                  tags$div("Vazire, S., Schiavone, S. R., & Bottesini, J. G. (2022). Credibility Beyond Replicability: Improving the Four Validities in Psychological Science.  ", tags$i("Current Directions in Psychological Science, 31"), "(2), 162–168. ", tags$a(href="https://journals.sagepub.com/doi/10.1177/09637214211067779", "https://doi.org/10.1177/09637214211067779"), ". Preprint available ", tags$a(href="https://psyarxiv.com/bu4d3/", "here.")) 
                 
    ))),
    
# page: faqs   ---------------------------
    
    tabItem(tabName = "faqs",
            
      h3("Frequently asked questions"),

      fluidRow(
        box(width = 12, solidHeader = F, status ="primary", title = NULL,
            
            h5(icon("question-circle"), "What can I do with this report?", style = "font-weight: bold; color: black"),
            p("Whatever you want! You can use this when reviewing papers and submit the report along with your review to the journal, share it as a post-publication peer review online, use in journal clubs or when teaching students about validity and peer review, etc."),
            
            h5(icon("question"), "Why was this developed?", style = "font-weight: bold; color: black"),
            tags$div("This app was developed to aid researchers in evaluating threats to the validity of quantitative empirical research and to communicate concerns about validity. A paper introducing and explaining this tool can be ",
              tags$a(href=" ", "here (link to preprint coming soon!).")
            ),
            
            h5(icon("question-circle"), "How was this developed?", style = "font-weight: bold; color: black"),
            tags$div("We used a ‘reactive-Delphi’ expert consensus process in which over 50 experts provided feedback across multiple rounds of item generation and refinement. Our aim was to select a manageable number of threats in each of the four validity categories, prioritizing threats that are most common and most serious in psychology research, however researchers and reviewers in nearby disciplines may find it useful or easy to adapt. Additional information is available",
              tags$a(href=" ", " here (link to preprint or OSF coming soon!)")
            ),
           
            h5(icon("question"), "Who was this developed by?", style = "font-weight: bold; color: black"),
            tags$div("The list of potential threats to validity were authored by Sarah R. Schiavone, Simine Vazire, and Kimberly Quinn. This website/Shiny application was designed by Sarah R. Schiavone. The source code is available on ", 
            tags$a(href="https://github.com/schiavone1/seaboat", "GitHub.")
            ),
            
            h5(icon("question-circle"), "Why is this called Seaboat?", style = "font-weight: bold; color: black"),
            p("Sea boats are vessels that must withstand the extreme conditions and heavy storms faced on the open sea. Validity threats are, in a way, like holes in the woodwork of a vessel that leave the research vuneralable to the crashing waves. Also, Sarah once called a sea plane a seaboat, and it was funny."),
            
            h5(icon("question"), "How can I submit feedback or report a problem?", style = "font-weight: bold; color: black"),
            tags$div("If you encounter any issues or would like to send us feedback or ideas on how to improve this app, you can do so by submitting an issue on ",
            tags$a(href="https://github.com/schiavone1/seaboat", "GitHub"),"or using this ",
            tags$a(href="https://forms.gle/6ERLjweioC58Lw749", "form.")
            ),
          )
        )
      )
)))

