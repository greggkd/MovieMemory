

import Foundation

class Card {
    var imageName: String
    var isFlipped: Bool
    var isMatched: Bool
    var movie: MovieObj
    var textValue: String
    
    init(imageName: String, movie: MovieObj, textValue: String){
        self.imageName = imageName
        self.isFlipped = false
        self.isMatched = false
        self.movie = MovieObj(
            Title: movie.Title,
            Year: movie.Year,
            Genre: movie.Genre,
            Released: movie.Released,
            Director: movie.Director,
            Writer: movie.Writer,
            Actors: movie.Actors,
            Plot: movie.Plot,
            Language: movie.Language,
            Country: movie.Country,
            Awards: movie.Awards,
            BoxOffice: movie.BoxOffice,
            Poster: movie.Poster)
        self.textValue = textValue
    }
}
