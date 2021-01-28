################################################################################
## Project: IPVA profiles
## Script purpose: Creating figure 2 and 3 for JIPV submission - spider plot for impact,
# dots and whiskers of probabilities and SEs for perpetration
## Both between victimissation classes
## Date: 27th March 2020
## Author: Annie Herbert
## Email: annie.herbert@bristol.ac.uk
################################################################################

################################################################################
# 0. Locations, packages, functions

# Note that in Cmder, need to set drive:
# cd C:\Program Files\R\R-3.5.3\bin

# install.packages("readstata13")

packages<-c('readxl','readstata13','ggplot2','devtools','ggpubr','gridExtra','fmsb','ggiraphExtra')

source("http://bioconductor.org/biocLite.R")

for(pkg in packages){
  if(!require(pkg,character.only=T)){
    biocLite(pkg,suppressUpdates=TRUE)
    library(pkg,character.only=T)
    }
  }

rm(pkg,packages)


################################################################################

## ---- Clear global R environment----------------------------------------------
rm(list=ls())


## ---- Location files----------------------------------------------------------
loc_inp<-'A:/Quant/P2 - Profiles/JIPV/results/'
loc_out<-loc_inp
setwd(loc_out)


################################################################################
# 1. Figure 2 - spider plot of impact  
################################################################################

## ---- Read in data -------------------------------------------------------------------
prof.dta <- read_excel(paste0(loc_inp,'fig2.xlsx'))
prof.dta <- as.data.frame(prof.dta)

#Needs to be ordered for plot to work
prof.dta <- prof.dta[order(prof.dta$sex, prof.dta$outcome, prof.dta$class_paper), ]
prof.dta$outcome <- factor(prof.dta$outcome)
prof.dta$class_paper <- as.vector(prof.dta$class_paper)
prof.dta$class_paper <- factor(prof.dta$class_paper, 
  levels=c("No-low", "Mainly psych", "Psych+phys", "Psych+sex", "Multi-vic"))

plots <- lapply(c("Women","Men"), 
  function(x) 
  assign(paste0("plot_",x), 
    ggplot(data=prof.dta[prof.dta$sex==x,],  
    aes(x=outcome, y=prob, group=class_paper, colour=class_paper)) + 
      annotate("text", x = 1, y = 0, label = "0.00", hjust = 1, size = 2) +
      annotate("text", x = 1, y = 0.25, label = "0.25", hjust = 1, size = 2) +
      annotate("text", x = 1, y = 0.50, label = "0.50", hjust = 1, size = 2) +
      annotate("text", x = 1, y = 0.75, label = "0.75", hjust = 1, size = 2) +
      annotate("text", x = 1, y = 1, label = "1.00", hjust = 1, size = 2) +
      geom_polygon(size = 1, alpha= 0.2, fill=NA) +
    geom_point(size = 2, alpha= 0.2, fill=NA) + 
      scale_y_continuous(labels = NULL) +
      scale_x_discrete() +
        scale_color_brewer(palette="Dark2", name="Class") +    
    xlab("") +
      ylab("") +
      ggtitle(x) +
      theme_light()+
    coord_polar(start = -1.75*pi/12)
    ))
plots[1]

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(plots[[1]])

#Combine plots
tiff('fig2.tif', width = 800, height = 500, unit = "px")
grid.arrange(arrangeGrob(plots[[1]] + theme(legend.position="none"),
                         plots[[2]] + theme(legend.position="none"),
                         ncol=2, widths=c(10,10)),
                mylegend, 
                nrow=1, widths=c(8.5,1.5)
         )
dev.off()


################################################################################
# 2. Figure 3 - Dots and whiskers plot of perpetration outcomes
################################################################################

prof.dta <- read_excel(paste0(loc_inp,'fig3.xlsx'))
prof.dta <- as.data.frame(prof.dta)

prof.dta$ll <- prof.dta$prob-prof.dta$se
prof.dta$ul <- prof.dta$prob+prof.dta$se
prof.dta$sex <- factor(prof.dta$sex)
prof.dta$class_paper <- factor(prof.dta$class_paper, levels=c("No-low","Mainly psych","Psych+phys","Psych+sex","Multi-vic",""," "))
prof.dta$outcome <- as.vector(prof.dta$outcome)
prof.dta$outcome <- factor(prof.dta$outcome, levels=c("Explicit Psych","Coercive Psych","Physical","Sexual"))

ymin <- round(min(prof.dta$ll, na.rm=TRUE),digits=1)-0.1
ymax <- round(max(prof.dta$ul, na.rm=TRUE),digits=1)+0.1

plots <- lapply(c("Women","Men"), 
  function(x) 
  assign(paste0("plot_",x), 
    ggplot(prof.dta[prof.dta$sex==x & order(prof.dta$outcome),], 
      aes(x = class_paper, y = prob, ymin = ll, ymax = ul)) + 
    geom_pointrange(aes(col=outcome), 
      position=position_dodge(width=0.30)) +
    ylim(ymin,ymax) + 
    xlab("") +
    ylab("") +
    scale_color_brewer(palette="Dark2", name="Perpetration sub-type") +
    #scale_color_discrete(name = "Class") +
    ggtitle(x) +
    theme(axis.text.x = element_text(angle = 65, hjust = 1, size = 12))
    ))

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(plots[[1]])

#Combine plots
tiff('fig3.tif', width = 800, height = 500, unit = "px")
grid.arrange(arrangeGrob(plots[[1]] + theme(legend.position="none"),
                         plots[[2]] + theme(legend.position="none"),
                         ncol=2, widths=c(10,6)),
                bottom = text_grob("Class"),
                left = text_grob("Risks (standard errors)",rot=90), 
                mylegend, 
                nrow=1, widths=c(8.5,1.5)
         )
dev.off()