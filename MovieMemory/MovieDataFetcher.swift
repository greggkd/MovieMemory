
import Foundation

//struct MovieDataFetcher  {
class MovieDataFetcher {
    
    // nested function
    func createURLWithComponents(movie: String) -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = "http";
        urlComponents.host = "www.omdbapi.com";
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: "bf3dfbba"),
            URLQueryItem(name: "t", value: movie)
        ]
        
        return urlComponents.url
    }
    
    func fetchMovieDeets(movie: String = "frozen", completion: @escaping (MovieObj) -> ()){
        let myUrl = createURLWithComponents(movie: movie)
        var myRequest = URLRequest(url: myUrl!)
        
        myRequest.httpMethod = "GET"
        //myRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let myConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: myConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        
        //print(myRequest.description, "hmm")
        
        let myTask = session.dataTask(with: myRequest) { (data, response, error) in
            
            if (error != nil) {
                print("Error1 fetching JSON data")
            }
            else {
                do {
                    //Decode retrieved data with JSONDecoder and assing type of Station object
                    let movieData = try JSONDecoder().decode(MovieObj.self, from: data!)
                    DispatchQueue.main.async {
                        completion(movieData)
                    }
                }
                catch let error {
                    print(error)
                }
            }
        }
        myTask.resume()
        
    }
    
}



