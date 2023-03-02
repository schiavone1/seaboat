library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
#suppressMessages(library(tidyverse))

## validity threats  ----------

construct_list <-   c("C1. Construct(s) were poorly defined (e.g., inconsistent and/or unclear definitions).",
                      "C2. Insufficient information provided about how the constructs were operationalized.", 
                      "C3. Reliability of measures is not considered or issues with reliability are overlooked.",
                      "C4. Measures or manipulations (or how they were administered) likely introduced error (e.g., demand characteristics, social desirability, inattentive responding).",
                      "C5. Insufficient evidence of, or attention to, the validity of measures or manipulations."
                      )

statistical_list <- c("S1.  Insufficient information provided about the analyses to evaluate (or reproduce) the results.",  
                      "S2.  Low statistical power or precision to detect the effect of interest (e.g., small sample size/number of observations).",
                      "S3.  Unknown or unclear stopping rules for data collection.",
                      "S4.  Data exclusions were not sufficiently justified, outliers were treated inconsistently between similar studies, an unusually large number of observations were excluded, or it was otherwise unknown how exclusions impacted the results.",
                      "S5.  Insufficient safeguards against flexible analysis decisions (e.g., dropping items or measures, transforming variables, haphazard inclusion of controls variables). Safeguards could include detailed preregistrations, direct replications, or robustness checks. Reporting results as exploratory with no confirmatory statistics or interpretations could also mitigate these concerns.",
                      "S6.  Poor match between substantive hypothesis and statistical test.",
                      "S7.  Overinterpreted statistically ambiguous results (e.g., “marginally significant”, “trending towards significance”) or statistically unlikely results (e.g., a series of statistically significant results across studies, with none or few of the p-values below .01. True effects should produce heavily-skewed distributions of p-values, with most p-values below .01.)",
                      "S8.  Treated dependent observations (e.g., data clustered within persons, groups, countries) as independent; did not account for interdependence.",
                      "S9.  Overinterpreted statistically ambiguous or uncertain results as significant/meaningful (e.g., “marginally significant”, “trending towards significance”).",
                      "S10. Interpreted results as evidence of “no difference” or “no effect” based only on non-significant p-values without directly testing for evidence of absence (e.g., using equivalence testing or Bayesian statistics).",
                      "S11. Failed to directly test or estimate the effect of interest (e.g., reporting that two effects differ because one is statistically significant and the other is not, rather than testing the interaction directly)",
                      "S12. Interpreted results as support for a hypothesis even though the pattern of results was not as predicted (e.g., hypothesized an interaction where cell A1 would be lower than cells A2, B1, and B2, but the pattern of results does not look like that).",
                      "S13. HARKing (Hypothesizing After the Results are Known): The results were presented as “predicted”, without documentation of a priori predictions (e.g., preregistration) and there is reason to doubt this (e.g., theory is vague, result focuses on subgroup analysis)."
                      )

internal_list <-    c("I1. There are likely confounding variables (i.e., variables that might cause both the presumed predictor and the outcome) that were not accounted for.",
                      "I2. Selective or differential attrition: Missing data were likely related to the measures or manipulations.",
                      "I3. Findings about change over time were reported without a control or comparison group, for which alternative explanations (e.g., maturation, history, testing effects, regression to the mean) are likely.",
                      "I4. The outcome could have caused the predictor (i.e., reverse causality).",
                      "I5. The comparison groups may have differed in unintended ways (e.g., concerns about whether participants were randomly assigned to experimental conditions, groups were poorly matched).",
                      "I6. Researchers and/or participants were aware of which condition participants were in.",
                      "I7. Did not rule out order effects in within-person designs.",
                      "I8. The procedures for the control and experimental groups were not well-matched (i.e., differed in ways other than levels of the IV)."
                      )
      
external_list <-    c("E1. The authors did not make it clear to what range of people, settings, measures, etc. they believe their findings do and do not generalize.",
                      "E2. Important sample characteristics were not reported (or measured).",
                      "E3. Claimed—or strongly implied—that their results generalize to populations that the sample did not adequately represent.",
                      "E4. The sample recruited did not match the population of interest (e.g., sampled only college students when the research question was about psychiatric populations).",
                      "E5. Claimed—or strongly implied—that effects generalize beyond the specific measures, manipulations, or settings sampled when the design does not allow for such generalization.",
                      "E6. Claimed implications for real-world phenomena far beyond what was studied."
                      )
    

standard_radioButtons <- function(name, character){
  radioButtons(name, HTML(character),
               choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7),
               inline = TRUE,  selected = FALSE)
}

quick_updateRadioButtons <- function(variable, session){
  updateRadioButtons(session, variable,
                     choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5, "6" = 6, "7" = 7),
                     inline = TRUE, selected = FALSE)
}  


headYaml <- "
---
title: '&studyTitle'
subtitle: 'Review of Validity Threats'
author: '&authorNames'
date: '&date'
output: &save.as
---

# Construct Validity Threats: 

**Potential threats identified:** &cv_items

**Overall rating, from 1 (very low) to 7 (very high):** &cv_rating

**Notes or additional concerns about construct validity:** &cv_com

# Statistical Conclusion Validity Threats:
**Potential threats identified:** &sv_items

**Overall rating, from 1 (very low) to 7 (very high):** &sv_rating

**Notes or additional concerns about statistical conclusion validity:** &sv_com

# Internal Validity Threats
**Potential threats identified:**  &iv_items

**Overall rating, from 1 (very low) to 7 (very high):** &iv_rating

**Notes or additional concerns about internal validity:** &iv_com

# External Validity Threats
**Potential threats identified:** &ev_items

**Overall rating, from 1 (very low) to 7 (very high):** &ev_rating

**Notes or additional concerns about external validity:**  &ev_com

# Other Validity Threats 
**Other potential threats to validity identified:** &other_com

## Additional Comments
  &comments

# 
# About This Report:
This report was created using http://www.seaboat.io/. A preprint describing this tool is available at ______ (Schiavone, Quinn, and Vaizre, 2022).
"

composeRmd <- function(answers = NULL){
  
  #print(answers)
  date <- format(Sys.time(), '%d %B, %Y')
  answers$reporttitle  <- ifelse(answers$reporttitle == "", "Untitled", answers$reporttitle)
  answers$author       <- ifelse(answers$author == "", "Anonymous", answers$author)
  answers$comments     <- ifelse(answers$comments == "", "None", answers$comments)

  answers$cv_items     <- ifelse(is.null(answers$cv_items), "None identified", paste0(answers$cv_items, collapse = '; '))
  answers$cv_com       <- ifelse(answers$cv_com == "", "None", answers$cv_com)
  answers$cv_rating    <- ifelse(is.null(answers$cv_rating), "Not rated", answers$cv_rating)
  
  answers$sv_items     <- ifelse(is.null(answers$sv_items), "None identified", paste0(answers$sv_items, collapse = '; '))
  answers$sv_com       <- ifelse(answers$sv_com == "", "None", answers$sv_com)
  answers$sv_rating    <- ifelse(is.null(answers$sv_rating), "Not rated", answers$sv_rating)
  
  answers$iv_items     <- ifelse(is.null(answers$iv_items), "None identified", paste0(answers$iv_items, collapse = '; '))
  answers$iv_com       <- ifelse(answers$iv_com == "", "None", answers$iv_com)
  answers$iv_rating    <- ifelse(is.null(answers$iv_rating), "Not rated", answers$iv_rating)
  
  answers$ev_items     <- ifelse(is.null(answers$ev_items), "None identified", paste0(answers$ev_items, collapse = '; '))
  answers$ev_com       <- ifelse(answers$ev_com == "", "None", answers$ev_com)
  answers$ev_rating    <- ifelse(is.null(answers$ev_rating), "Not rated", answers$ev_rating)
  
  answers$other_com    <- ifelse(answers$other_com == "", "None", answers$other_com)
  answers$save.as      <- ifelse(answers$save.as   == "word", "word_document",
                          ifelse(answers$save.as   == "pdf", "pdf_document",  
                          ifelse(answers$save.as   == "md", "md_document","html_document")))
  
 # print(answers)
  
  headYaml <- gsub("&studyTitle",         answers$reporttitle,   headYaml)
  headYaml <- gsub("&authorNames",        answers$author,        headYaml)
  headYaml <- gsub("&date",               date,                  headYaml)
  
  headYaml <- gsub("&cv_items",           answers$cv_items,      headYaml)
  headYaml <- gsub("&cv_com",             answers$cv_com,        headYaml)
  headYaml <- gsub("&cv_rating",          answers$cv_rating,      headYaml)
  
  headYaml <- gsub("&sv_items",           answers$sv_items,      headYaml)
  headYaml <- gsub("&sv_com",             answers$sv_com,        headYaml)
  headYaml <- gsub("&sv_rating",          answers$sv_rating,      headYaml)
  
  headYaml <- gsub("&iv_items",           answers$iv_items,      headYaml)
  headYaml <- gsub("&iv_com",             answers$iv_com,        headYaml)
  headYaml <- gsub("&iv_rating",          answers$iv_rating,      headYaml)
  
  headYaml <- gsub("&ev_items",           answers$ev_items,      headYaml)
  headYaml <- gsub("&ev_com",             answers$ev_com,        headYaml)
  headYaml <- gsub("&ev_rating",          answers$ev_rating,      headYaml)
  
  headYaml <- gsub("&other_com",          answers$other_com,        headYaml)
  headYaml <- gsub("&comments",           answers$comments,      headYaml)
  
  headYaml <- gsub("&save.as",            answers$save.as,      headYaml)
  headYaml
 # print(answers)
}

