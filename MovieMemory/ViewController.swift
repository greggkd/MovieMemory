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
    
    let movieModel = MovieModel()               
    //let movieModel: MovieModel = MovieModel()
    let cardModel = CardModel()
    var cardArray = [Card]()
    var movieArray = [MovieObj]()
    
    var firstFlippedCardIndex: IndexPath?
    var timer:Timer?
    var milliseconds: Float = 30 * 1000 //10 seconds
    
    var timerEnd = ""
    
    var dataAvailableDelegate: DataAvailableDelegate?
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        movieModel.movieData.dataAvailableDelegate = self as DataAvailableDelegate
        dataAvailableDelegate?.dataAvailable()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        //The following allows room for the timer at the top
        collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: itemSize, height: itemSize)
//        //layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
//        layout.minimumLineSpacing = 2
//        layout.minimumInteritemSpacing = 2
//        myCollectionView.collectionViewLayout = layout
//        
//        
//        self.view.layer.cornerRadius = 30.0
//        self.view.layer.borderWidth = 5
        self.view.layer.shadowOpacity = 0.7
        
        startTimer()
        
    }//EOF viewDidLoad
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    func startTimer(){
        milliseconds = 30 * 1000
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

        //print(cardArray.count, "card count")
        return cardArray.count
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell


        
        cell.imageView.isHidden =  true
        cell.frontImageView.isHidden = false
        
        let card = cardArray[indexPath.row]
        
        let radius: CGFloat = cell.imageView.frame.width / 2.0
        let shadowPath2 = UIBezierPath(rect: CGRect(x:0, y:0, width: 2.1 * radius, height: cell.frame.height))
        cell.imageView.layer.cornerRadius = 30.0
        cell.imageView.layer.borderWidth = 5
        //cell.layer.shadowOffset = (CGSize(width: 0.6, height: 4.0))
//        cell.imageView.layer.shadowColor = UIColor.purple.cgColor
//        cell.imageView.layer.shadowOffset = CGSize(width: 10, height: 10)  //Here you control x and y
//        cell.imageView.layer.shadowOpacity = 0.5
//        cell.imageView.layer.shadowRadius = 5.0 //Here your control your blur
        //cell.imageView.layer.masksToBounds =  false
        cell.imageView.layer.shadowPath = shadowPath2.cgPath
        
        
        let radius2: CGFloat = cell.frame.width / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius2, height: cell.frame.height))
        //cell.layer.cornerRadius = 30.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 4.0)  //Here you control x and y
        cell.layer.shadowOpacity = 0.75
        cell.layer.masksToBounds =  false
        cell.layer.shadowPath = shadowPath.cgPath
        
//        cell.imageView.layer.shadowOpacity = 0.7
//        cell.imageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        
        cell.frontImageView.layer.cornerRadius = 30.0
        cell.frontImageView.layer.borderWidth = 5
        
//        cell.frontImageView.layer.shadowOpacity = 0.7
//        cell.frontImageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        
        cell.setCard(card, indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        
        let card = cardArray[indexPath.row]

        if card.isFlipped == false && card.isMatched == false{
            cell.flip()
            SoundManager.playSound(.flip)
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
                SoundManager.playSound(.match)
                //Set the statuses of the cards
                cardOne.isMatched = true
                cardTwo.isMatched = true
                
                //Remove the cards from the grid
                cardOneCell?.remove()
                cardTwoCell?.remove()
                //collectionView.reloadItems(at: [firstFlippedCardIndex!])
                //collectionView.reloadItems(at: [secondFlippedCardIndex])
                
                //Check if there are any cards left unmatched
                checkGameEnded()
                
            }else{
                //Not a match
                SoundManager.playSound(.nomatch)
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
                timerEnd = timerLabel.text!
                print("timerEnd", timerEnd)
            }
            
            title = "Congratulations"
            message = "You've won!"
            
        }else{
            
            if milliseconds > 0 {
                return
            }
            timer?.invalidate()
            timerEnd = timerLabel.text!
            print("timerEnd", timerEnd)
            title = "Game Over"
            message = "You've Lost"
            
        }
        //Show won/lost messaging
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertQuitAction = UIAlertAction(title: "Quit", style: .default, handler: { (action: UIAlertAction!) in self.quitWasPressed() } )
        let alertAgainAction = UIAlertAction(title: "Play Again", style: .default, handler: { (action: UIAlertAction!) in self.againWasPressed() } )
        alert.addAction(alertQuitAction)
        alert.addAction(alertAgainAction)
        present(alert, animated: true, completion: nil)
    }
    //Quit Alert Button Logic
    func quitWasPressed(){
        //exit(0)
        UserDefaults.standard.set(self.timerEnd, forKey: "thisTime")
        self.performSegue(withIdentifier: "showSplash", sender: self )
    }
    
    //Play Again Alert Button Logic
    func againWasPressed(){
        self.performSegue(withIdentifier: "showThanks", sender: self)
        cardArray = cardModel.resetFlags(cards: cardArray)
        self.dataAvailable()
        startTimer()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showSplash"{
            // Create a variable that you want to send
            //let newVar = self.model.puppyData.allPuppies

            // Create a new variable to store the instance of PlayerTableViewController
            let destinationVC = segue.destination as! SplashViewController
            destinationVC.timeEnd = self.timerEnd
        }
        
        if segue.identifier == "showThanks"{
            _ = segue.destination as! ThanksViewController
        }
    }
    
}//EOF VC



extension ViewController: DataAvailableDelegate{
    func dataAvailable() {
      
        self.collectionView.reloadData()
        if movieModel.movieData.count >= 6 {
            movieArray = movieModel.movieData.allMovies
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
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

