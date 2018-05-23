//
//  CustomCollectionViewCell.swift
//  MovieMemory
//
//  Created by Karen Gregg on 5/16/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        imageView.downloadedFrom(link: card.movie.Poster)
        nameLbl.text = card.movie.Title
        textView2.text = card.movie.Actors
        if card.isMatched == true {
            
        }
    }
    
    func flip() {
        UIView.transition(from: imageView, to: textView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        UIView.transition(from: textView, to: imageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
}
