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
    
    var firstFlippedCardIndex: IndexPath?
    var timer:Timer?
    var milliseconds: Float = 10 * 1000 //10 seconds
    
    var dataAvailableDelegate: DataAvailableDelegate?
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var posterImage: UIImageView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        movieModel.movieData.dataAvailableDelegate = self as DataAvailableDelegate
        dataAvailableDelegate?.dataAvailable()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    //MARK: Timer Methods
    @objc func timerElapsed(){
        milliseconds -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //Set Label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        //Stop the timer when it reaches 0
        if milliseconds <= 0{
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
        }
    }
    //MARK: - UICOLLECTIONVIEW PROCTOCOL METHODS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print(cardArray.count, "card count")
        return cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell

        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card, indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        let card = cardArray[indexPath.row]
        print("im here")
        if card.isFlipped == false && card.isMatched == false{
            cell.flip()
            card.isFlipped = true
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }else
            {
                checkForMatches(indexPath)
            }
        }

        }//EOF didSelectItemAt
        
        //MARK: Game Logic Methods
        
        func checkForMatches(_ secondFlippedCardIndex: IndexPath){
            //Get the cells for the two cards that were revealed
            let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CustomCollectionViewCell
            let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CustomCollectionViewCell
            
            //Get the cards for the two cards that were revealed
            let cardOne = cardArray[firstFlippedCardIndex!.row]
            let cardTwo = cardArray[secondFlippedCardIndex.row]
            
            if cardOne.imageName == cardTwo.imageName {
                //It's a match
                
                //Set the statuses of the cards
                cardOne.isMatched = true
                cardTwo.isMatched = true
                
                //Remove the cards from the grid
                cardOneCell?.remove()
                cardTwoCell?.remove()
                collectionView.reloadItems(at: [firstFlippedCardIndex!])
                collectionView.reloadItems(at: [secondFlippedCardIndex])
                
                //Check if there are any cards left unmatched
                checkGameEnded()
                
            }else{
                //Not a match
                //Set the status of the cards
                cardOne.isFlipped = false
                cardTwo.isFlipped = false
                //Flip both cards back
                cardOneCell?.flipBack()
                cardTwoCell?.flipBack()
            }
            //Tell the collectionview to reload the cell of the first card if it is nil
            if cardOneCell == nil {
                collectionView.reloadItems(at: [firstFlippedCardIndex!])
            }
            //Reset the property that tracks the first card flipped
            firstFlippedCardIndex = nil
        }//EOF checkForMatches
    
    func checkGameEnded(){
        //Determine if there are any cards unmatched
        var isWon = true
        //If not then user has won, stop the timer
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        //Messaging variables
        var message = ""
        var title = ""
        
        
        //If there are unmatched cards, see if there is any time left
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You've won!"
            
        }else{
            
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've Lost"
            
        }
        //Show won/lost messaging
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
        
}//EOF VC



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

