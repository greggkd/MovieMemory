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
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    var firstFlippedCardIndex:IndexPath?
    
    var card:Card?
    //var cardOne: Card()
    
    func setCard(_ card:Card, _ thisCardIndexPath: IndexPath) {
        
        self.card = card
        //self.card?.thisCardIndexPath = thisCardIndexPath
        imageView.downloadedFrom(link: card.movie.Poster)
        nameLbl.text = card.imageName


        let textViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flip))
        textView?.addGestureRecognizer(textViewGesture)
        
        textView?.text = card.textValue
        textView?.delegate = self
        
//        if card.isMatched == true {
//
//        }
    }

    func flipBack() {
        print("there")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //We will be showing the Poster so flip to the textView
            UIView.transition(from: self.imageView, to: self.frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            //self.card?.isFlipped = true
            //self.nameLbl.text = self.card?.imageName
        }
        

    }
    
    @objc func flip() {
        print("top of flip ")
        
        //We will be showing the textView so flip to the Poster
        UIView.transition(from: frontImageView, to: imageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        //card?.isFlipped = true
        nameLbl.text = card?.movie.Title
        
    }//EOF flip()
    
    func remove() {
        //Removes from grid
        //TODO: animate it
        imageView.alpha = 0
        frontImageView.alpha = 0
        //textView?.alpha = 0
        //nameLbl.alpha = 0
    }
    

}//EOF CustomCollectionViewCell



