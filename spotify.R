#input spotify data
spotify_data <- data.frame(
  title = c("Silver Lining", "Beggar's Song", "Maine", "Beautiful Things", "Half of forever"),
  artist = c("Mt. Joy", "Matt Maeson","Noah Kahan", "Benson Boone", "Henrik"),
  duration = c("199", "235", "233", "180","153"),
  stringAsFactors = FALSE
)

#preview the data
head(spotify_data, 6) #displays the first n rows present in the input data frame
list(spotify_data, 6)

#check generic functions accuracy
summary(spotify_data)

#check the class of the dataset
class(spotify_data) #this should have a return of "data.frame"
typeof(spotify_data) #determines that the data type or storage mode of an object, what kind of data a variable is

#S3 example
#create an S3 class for multiple songs
create_song <- function(title, artist, duration) {
  song <- list (title = title, artist = artist, duration = as.numeric(duration))
  class(song) <- "song"
  return(song)
}

#define a print method for a single song
print.song <- function(x) {
  cat("Title:", x$title, "\n")
  cat("Artist:", x$artist, "\n")
  cat("Duration:", x$duration, "seconds\n")
}

#define a summary method for a single song
summary.song <- function(x) {
  paste("Song:", x$title, "by", x$artist, "-", x$duration, "seconds")
}

#multiple songs data
titles <- c("Silver Lining", "Beggar's Song", "Maine", "Beautiful Things", "Half of forever")
artists <- c("Mt. Joy", "Matt Maeson", "Noah Kahan", "Benson Boone", "Henrik")
durations <- c("199", "235", "233", "180", "153")

#create a list of song objects 
songs <- list()
for (i in 1:length(titles)) {
  songs[[i]] <- create_song(titles[i], artists[i], durations[i])
}

#print the songs and summarize
for (song in songs) {
  print(song)  #will use the print.song method for each
  cat("\n")    #add space between songs
}
summaries <- sapply(songs, summary.song)
print(summaries)

#S4 example
#define the class
setClass("song",
         slots = list(title = "character", artist = "character", duration = "numeric"))

#initialize the song objects
create_song_S4 <- function(title, artist, duration) {
  new("song", title = title, artist = artist, duration = as.numeric(duration))
}

#define the show method 
setMethod("show", "song", function(object) {
  cat("Title:", object@title, "\n")
  cat("Artist:", object@artist, "\n")
  cat("Duration:", object@duration, "second\n")
})

#define summary method
setMethod("summary", "song", function(object) {
  paste("Song:", object@title, "by", object@artist, "-", object@duration, "seconds")
})

#create a list of song objects
songs_S4 <- list()
for (i in 1: length(titles)) {
  songs_S4[[i]] <- create_song_S4(titles[i], artists[i], durations[i])
}

#print all songs
for (song in songs_S4) {
  show(song)
  cat("\n")
}

#summarize
summaries_S4 <- sapply(songs_S4, summary)
print(summaries_S4)
