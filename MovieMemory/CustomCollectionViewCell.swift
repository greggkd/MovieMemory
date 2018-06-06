//
//  CustomCollectionViewCell.swift
//  MovieMemory
//
//  Created by Karen Gregg on 5/16/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    var firstFlippedCardIndex:IndexPath?
    
    var card:Card?
    //var cardOne: Card()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 10
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    func setCard(_ card:Card, _ thisCardIndexPath: IndexPath) {
        
        self.card = card
        
        if card.isMatched == true {
            //if the card has been matched make the elements invisible
            imageView.alpha = 0
            frontImageView.alpha = 0
            
            return
            
        }else{
            imageView.alpha = 1
            frontImageView.alpha = 1
            frontImageView.layer.cornerRadius = 30
            imageView.layer.cornerRadius = 30
            
            imageView.layer.cornerRadius = 30.0
            imageView.layer.borderWidth = 5
            imageView.layer.shadowOpacity = 0.7
            imageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
            
            frontImageView.layer.cornerRadius = 30.0
            frontImageView.layer.borderWidth = 5
            frontImageView.layer.shadowOpacity = 0.7
            frontImageView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
            
            
            
        }
        
        imageView.downloadedFrom(link: card.movie.Poster)


//        let textViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flip))
//        textView?.addGestureRecognizer(textViewGesture)
        if card.isFlipped == true {
            UIView.transition(from: imageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }

        

    }

    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //We will be showing the Poster so flip to the textView
            UIView.transition(from: self.imageView, to: self.frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)

        }
        

    }
    
    @objc func flip() {
        
        //We will be showing the textView so flip to the Poster
        UIView.transition(from: frontImageView, to: imageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }//EOF flip()
    
    func remove() {
        //Removes from grid
        //imageView.alpha = 0
        
        // Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
            self.imageView.alpha = 0
        }, completion: nil)
        

    }
    

}//EOF CustomCollectionViewCell



