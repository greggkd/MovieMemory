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

        movieModel.movieData.dataAvailableDelegate = self as DataAvailableDelegate
        dataAvailableDelegate?.dataAvailable()

        collectionView.delegate = self
        collectionView.dataSource = self
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
//        cell.nameLbl.text = cardArray[indexPath.row].movie.Title
//        cell.imageView.downloadedFrom(link: cardArray[indexPath.row].movie.Poster)
//        cell.textView.text = cardArray[indexPath.row].movie.Actors
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            cell.flip()
            card.isFlipped = true
        }else{
            cell.flipBack()
            card.isFlipped = false
        }
        
    }
    
    
    
}



extension ViewController: DataAvailableDelegate{
    func dataAvailable() {
      
        //print("HELLPO " , movieModel.movieData.allMovies[0].Poster, "jfkdlsa;j;")
        self.collectionView.reloadData()
        if movieModel.movieData.count == 6 {
            movieArray = movieModel.movieData.allMovies
            print(movieArray, "blah blah blah", movieModel.movieData.count)
            cardArray = cardModel.getCards(movies: movieArray)
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

