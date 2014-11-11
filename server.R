library(shiny)
library(data.table)

porunidade <- function(lido, id){    
    ufoco <- data.table(lido[lido$unidade==id,], keep.rownames=TRUE, key="dataleitura")
    if(nrow(lido)>1){
        maxlen <- nrow(ufoco)-1
        data <- vector(mode="numeric", length=maxlen)
        qtde <- vector(mode="numeric", length=maxlen)
        dias <- vector(mode="numeric", length=maxlen)
        media <- vector(mode="numeric", length=maxlen)
        j <- 1
        for(i in 2:nrow(ufoco)){
            if(ufoco$leitura[i]>ufoco$leitura[i-1]){
                dlei <- ufoco$leitura[i]-ufoco$leitura[i-1]
                if(j==1 || ufoco$dataleitura[i]!=data[j-1]){
                    data[j] <- ufoco$dataleitura[i]
                    qtde[j] <- dlei
                    dias[j] <- ufoco$dataleitura[i]-ufoco$dataleitura[i-1]
                    if(dias[j]>0){
                        media[j] <- qtde[j] / dias[j]
                    }
                    j <- j+1
                } else {
                    qtde[j-1] <- qtde[j-1]+dlei
                    if(dias[j-1]>0){
                        media[j-1] <- qtde[j-1] / dias[j-1]
                    }
                }
            }
        }
        rm("ufoco")
        real <- 1:j-1
        return(data.table(data=as.Date(data[real], origin="1970-01-01"), 
                          qtde=qtde[real], dias=dias[real], media=media[real]))
    } else {
        rm("ufoco")
        return(NULL)
    }
}

shinyServer(
    
    function(input, output) {

        output$graph1 <- renderPlot({
            destfile <- ".\\data\\consumptionAVT.csv"
            consumo <- read.csv(destfile)
            consumo$dataleitura <- as.Date(as.character(consumo$dataleitura), format("%d/%m/%Y"))
            consumo$leitura <- as.numeric(gsub(",", ".", as.character(consumo$leitura)))
            foco <- input$foco
            mediafoco <- porunidade(consumo, foco)
            if(foco == "avt"){
                ylab <- "Daily consumption in 1000 liters per day"
                limite <- 10.5
                limitetoshow <- limite * 1000
                ylim <- c(0, 13)
            } else {
                mediafoco$qtde <- mediafoco$qtde*1000
                mediafoco$media <- mediafoco$media*1000
                ylab <- "Daily consumption in liters per day"
                if(foco=="common"){
                    limite <- 0
                } else {
                    limite <- 500
                }
                limitetoshow <- limite
                ylim <- c(0, 1800)
            }
            if(length(mediafoco) != 0){
                dias <- sum(mediafoco$dias)
                bruto <- sum(mediafoco$media*mediafoco$dias)
                if(foco == "avt") {
                    media <- as.integer(bruto*1000/dias)                    
                } else {
                    media <- as.integer(bruto/dias)                    
                }
                if(limite == 0){
                    textolimite <- "Common expense, divided equally, included in the monthly fee."
                } else {
                    textolimite <- paste("Green line = daily limit of", limitetoshow, "liters.")
                    if(max(mediafoco$media) > 2*limitetoshow){
                        textolimite <- paste(textolimite, "Red line = consuption above", 
                                             limitetoshow*2, "liters.")
                    } else {
                        if(max(mediafoco$media)<limite){
                            textolimite <- "Congrats! Consumption did not exceed the limit (green line) on any day."
                        }
                    }
                }
                if(foco != "avt" && foco != "common"){
                    axis(2, tck=.1, las=1, yaxt="n")
                }
                plot(mediafoco$data, mediafoco$media, type="l", 
                     main=paste(foco, "... mean =", media, "(liters/day)"), 
                     xlab=textolimite, ylab=ylab, ylim=ylim)
                if(foco != "common"){
                    abline(h=limite, col="green")
                    if(foco != "avt"){
                        abline(h=limite*2, col="red")
                        abline(h=limite*3, col="purple")
                        abline(h=media, lty=3)
                    }
                } else {
                    abline(h=media, lty=3)
                }
            }
        })
    }
)
