protocol DataAvailableDelegate: class {
    func dataAvailable()

}

final class MovieModel{
    var movieData = MovieData()
    var currentMovieIndex: Int = 0

}
