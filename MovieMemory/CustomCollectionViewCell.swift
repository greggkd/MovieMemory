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
    @IBOutlet weak var textView: UITextView!
    
    var card:Card?
    
    
    func setCard(_ card:Card) {
        
        self.card = card
        imageView.downloadedFrom(link: card.movie.Poster)
        nameLbl.text = card.imageName


        let textViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipBack))
        textView.addGestureRecognizer(textViewGesture)
        
        textView.text = card.textValue
        textView.delegate = self
        
        if card.isMatched == true {
            
        }
    }

    func flip() {
        print("there")
        //We will be showing the Poster so flip to the textView
        UIView.transition(from: imageView, to: textView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        card?.isFlipped = true
        nameLbl.text = card?.imageName
    }
    
    @objc func flipBack() {
        print("here ")
        //We will be showing the textView so flip to the Poster
        UIView.transition(from: textView, to: imageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        card?.isFlipped = false
        nameLbl.text = card?.movie.Title
        
    }
}



