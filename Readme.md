---
title: "Water Consuption by Households in AVT"
author: "fmarianoc"
date: "Monday, November 10, 2014"
output:
  html_document:
    self_contained: no
---

About a year ago I bought one house in a villa where the water consumption can be measured by residence, but the billing is sent to the villa as a single entity.  

There is a set limit of 500 liters per household per day and our villa has 21 houses, then we should keep consumption below 10,500 liters per day to pay a minimal fee.  

There is also the consumption of water in the common part, that needs to be washed from time to time, and where there are plants to be watered daily.  

The concessionaire does not recognize this separate consumption, so we need to divide it by the houses.  

Recently we started to extrapolate the limit of 10,500 liters per day and agree with the following rules:  

1. those who consume less than 500 liters per day pays only the minimum rate, which is already included in the condo fee.  

2. who consume more than 500 liters per day, prorates the proportion of the monthly invoice that extrapolates the 10,500 liters per day.  

In August, while doing the Reproducible Research course, I learned Knitr, build one application to construct the graphics of water consuption, and created a spreadsheet in Google Drive where I recorded measurements of water meters. I also recorded the data recovered from last year's water invoices of the Vila Tijuca.  

In the first 15 days of September I kept daily records, to show my neighbors how was their water usage depending on the day of the week.  

Then I started to keep records every 15 days to monitor the consumption and to have control over the consumption in order to avoid exceeding the limit of 10,500 liters per day.  

This application does not estimates nothing. It is a show graphs application that uses one combo box and one submit button. The data is in one .cvs file and each record have 5 variables:

- idmedidor :: the id of the water meter  
- unidade :: the id of the unity  
- dataleitura :: date of record  
- leitura :: value of record  
- coletivo :: factor {individual, common, villa}  

The target of this project is not ambitious, and I think that it was reached.  

Please, try it at https://fmarianoc.shinyapps.io/AVTWater/  
 

*Thank you.*  
