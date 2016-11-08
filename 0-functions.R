# functions

ba <- function(hits,ab){
  
  round(hits/ab,3)
  
}

obp <- function(hits,walks,hbp,ab,sf){
  
  round((hits + walks + hbp) / (ab + walks + hbp + sf),3)
  
}

sp <- function (h,double,triple,hr,ab){
  
  ((h - hr - double - triple) + (double * 2) + (triple * 3) + (hr * 4))/ab
}
  
                