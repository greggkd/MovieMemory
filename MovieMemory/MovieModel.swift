protocol DataAvailableDelegate: class {
    func dataAvailable()

}

final class MovieModel{
    var movieData = MovieData()
    var currentMovieIndex: Int = 0
    
    func returnElement(movie: MovieObj, ele: String) -> String {
        switch ele {
        case "Title":
            return movie.Title
        case "Year":
            return movie.Year
        case "Genre":
            return movie.Genre
        case "Released":
            return movie.Released
        case "Director":
            return movie.Director
        case "Writer":
            return movie.Writer
        case "Actors":
            return movie.Actors
        case "Plot":
            return movie.Plot
        case "Language":
            return movie.Language
        case "Country":
            return movie.Country
        case "Awards":
            return movie.Awards
        case "BoxOffice":
            return movie.BoxOffice
        case "Poster":
            return movie.Poster
        default:
            return "Ruht Roh Rorge"
        }
    }
}
