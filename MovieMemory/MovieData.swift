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
    var Poster: String
    var BoxOffice: String
    
    init(Title: String, Year: String, Genre: String, Released: String, Director: String, Writer: String, Actors: String, Plot: String, Language: String, Country: String, Awards: String, Poster: String, BoxOffice: String) {
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
        self.Poster = Poster
        self.BoxOffice = BoxOffice
    }
}

class MovieData {
    var allMovies = [MovieObj]()
    var poster: String = ""
    var count: Int {return allMovies.count}
    var movies = ["frozen", "guardians of the galaxy", "it", "shooter", "practical magic", "death cure"]
    //***************
    let movieDataFetcher: MovieDataFetcher
    
    weak var dataAvailableDelegate: DataAvailableDelegate?
    
    init() {
        movieDataFetcher = MovieDataFetcher()
        for movie in movies {
            movieDataFetcher.fetchMovieDeets(movie: movie){ [weak self] (movieData) in
                self?.allMovies.append(movieData)
                self?.dataAvailableDelegate?.dataAvailable()
            }
        }
        
        
    }

    
    
//***************
    
    
    
    
//    init(){
//        self.allMovies = []
//    }
    

//    func movie(at index: Int) -> MovieObj {
//        return allMovies[index]
//    }
//   
    
}

