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
        nameLbl.text = card.movie.Title

        let textViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipBack))
        textView.addGestureRecognizer(textViewGesture)
        
        textView.text = card.movie.Actors
        textView.delegate = self
        
        if card.isMatched == true {
            
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.textView.backgroundColor = UIColor.black
//    }
    
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        flipBack()
//
//    }

    func flip() {
        print("there")
        UIView.transition(from: imageView, to: textView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        card?.isFlipped = true
    }
    
    @objc func flipBack() {
        print("here ")
        UIView.transition(from: textView, to: imageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        card?.isFlipped = false
        
    }
}


class PassThroughTextView: UITextView {
    func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        print("********")
        if let next = next {
            next.touchesBegan(touches as! Set<UITouch>, with: event)
        }
        else {
            super.touchesBegan(touches as! Set<UITouch>, with: event)
        }
        
    }
    
    func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        print("&&&&&&")
        if let next = next {
            next.touchesEnded(touches as! Set<UITouch>, with: event)
        }
        else {
            super.touchesEnded(touches as! Set<UITouch>, with: event)
        }
    }
    
    func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        print("#########")
        if let next = next {
            next.touchesCancelled(touches as! Set<UITouch>, with: event)
        }
        else {
            super.touchesCancelled(touches as! Set<UITouch>, with: event)
        }
    }
    
    func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        print("@@@@@@")
        if let next = next{
            next.touchesMoved(touches as! Set<UITouch>, with: event)
        }
        else {
            super.touchesMoved(touches as! Set<UITouch>, with: event)
        }
    }
    
    
}
