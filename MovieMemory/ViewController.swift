//
//  ViewController.swift
//  MovieMemory
//
//  Created by Karen Gregg on 4/18/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import UIKit
//import Foundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let movieModel = MovieModel()               //what is the difference between these two calls?
    //let movieModel: MovieModel = MovieModel()
    let cardModel = CardModel()
    var cardArray = [Card]()
    var movieArray = [MovieObj]()
    
      var x = 0
    
    var dataAvailableDelegate: DataAvailableDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var posterImage: UIImageView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        movieModel.movieData.dataAvailableDelegate = self as DataAvailableDelegate
        print("before call to dataAvailable()")
        dataAvailableDelegate?.dataAvailable()
        print("after call to dataAvailable()")
        //print(cardArray[0].imageName, "imageName")
    }
    
    //MARK: - UICOLLECTIONVIEW PROCTOCOL METHODS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return movieModel.movieData.count
        print(cardArray.count, "card count")
        return cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
//        cell.nameLbl.text = movieModel.movieData.allMovies[indexPath.row].Title
//        cell.imageView.downloadedFrom(link: movieModel.movieData.allMovies[indexPath.row].Poster)
        cell.nameLbl.text = cardArray[indexPath.row].movie.Title
        cell.imageView.downloadedFrom(link: cardArray[indexPath.row].movie.Poster)
        return cell
    }
    
    
    
}



extension ViewController: DataAvailableDelegate{
    func dataAvailable() {
      
        //print("HELLPO " , movieModel.movieData.allMovies[0].Poster, "jfkdlsa;j;")
        self.collectionView.reloadData()
        if movieModel.movieData.count == 6 {
            movieArray = movieModel.movieData.allMovies
            print(movieArray, "fuck", movieModel.movieData.count)
            cardArray = cardModel.getCards(movies: movieArray)
            print(cardArray, "That was the cardArray")
        }
        
        
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

