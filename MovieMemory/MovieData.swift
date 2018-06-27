//import Foundation
import UIKit
import Foundation

//struct MovieDeets: Codable {
struct MovieObj: Codable {
    
    var Title: String
    var Year: String
    var Genre: String
    var Released: String
    var Director: String
    var Writer: String
    var Actors: String
    var Plot: String
    var Language: String
    var Country: String
    var Awards: String
    var BoxOffice: String
    var Poster: String
    
    
    init(Title: String, Year: String, Genre: String, Released: String, Director: String, Writer: String, Actors: String,
         Plot: String, Language: String, Country: String, Awards: String, BoxOffice: String, Poster: String) {
        self.Title = Title
        self.Year = Year
        self.Genre = Genre
        self.Released = Released
        self.Director = Director
        self.Writer = Writer
        self.Actors = Actors
        self.Plot = Plot
        self.Language = Language
        self.Country = Country
        self.Awards = Awards
        self.BoxOffice = BoxOffice
        self.Poster = Poster
    }
}

class MovieData {
    var allMovies = [MovieObj]()
    var count: Int {return allMovies.count}
    var movies = ["frozen", "guardians of the galaxy", "it", "shooter", "infinity war", "death cure", "jurassic world"]
    //***************
    let movieDataFetcher: MovieDataFetcher
    
    weak var dataAvailableDelegate: DataAvailableDelegate?
    
    //MARK: Base Requirement Two network calls (1)
    init() {
        movieDataFetcher = MovieDataFetcher()
        for movie in movies {
            movieDataFetcher.fetchMovieDeets(movie: movie){ [weak self] (movieData) in
                self?.allMovies.append(movieData)
                self?.dataAvailableDelegate?.dataAvailable()
            }
        }
}
    
    func movie(at index: Int) -> MovieObj {

        return allMovies[index]
    }
   
    func movieArray() -> [MovieObj] {
        return allMovies
    }
    

    
}


