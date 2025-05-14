library(pacman)
p_load(stringr, stringi, tidyverse)

codif_fonetico <- function(nombre) {
  nombre <- tolower(nombre)
  
  nombre <- gsub("ll", "y", nombre)
  nombre <- gsub("yn$", "in", nombre)
  nombre <- gsub("^hu", "w", nombre) #hu -> w :  Huanca, Huarachi
  nombre <- gsub("^hua", "wa", nombre)
  nombre <- gsub("^j", "y", nombre) #solo cuando inicia con j
  nombre <- gsub("ch", "x", nombre)
  nombre <- gsub("[aeiouh]", "", nombre)
  nombre <- gsub("v", "b", nombre)
  nombre <- gsub("z", "s", nombre)
  nombre <- str_replace_all(nombre, "c(?=[ei])", "s")  # ce/ci -> se/si
  nombre <- gsub("c", "k", nombre)          # ca/co/cu -> ka/ko/ku
  nombre <- gsub("qu", "k", nombre)
  nombre <- str_replace_all(nombre, "g(?=[ei])", "j")
  nombre <- gsub("gue|gui", "gi", nombre)
  nombre <- stri_trans_general(nombre, "Latin-ASCII")  #ñ a n, á a a, etc
  nombre <- gsub("(.)\\1+", "\\1", nombre)  # aa → a
  nombre <- gsub("[aeiou]", "", nombre)
  nombre <- gsub("y$", "i", nombre) #solo cuando termina con y
  
  toupper(nombre)
}

codif_fonetico(c("Johanna", "Yohanna", "Jenny", "Yeny", "Gonzales", "Gonzalez", "Huanca", "Huayna", "Evelyn", "Eveline", "Evelin", "AYLEN"))


#### Ejemplo

tribble(
  ~nombre,
  "ADOLFO AUZA PORTU",
  "ADOLFO AUSA PORTU",
  "JOSUE MENDEZ MAMA",
  "PALMIRA CRUZ",
  "NICOLE F SAUCANI"
) |> 
  separate(nombre, into = c("nombre1", "nombre2", "nombre3"), sep = " ") |> 
  mutate(across(starts_with("nombre"), ~codif_fonetico(.)))
