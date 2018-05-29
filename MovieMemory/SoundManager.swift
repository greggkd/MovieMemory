//
//  SoundManager.swift
//  MovieMemory
//
//  Created by Karen Gregg on 5/27/18.
//  Copyright © 2018 Karen Gregg. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager{
    //Adding "static" to the var and func allow us to call the method with out having
    //to instantiate an object ie. soundManager = SoundManager() in the ViewController.swift file
    static var audioPlayer:AVAudioPlayer?
    
    
    enum SoundEffect{
        case flip
        case shuffle
        case match
        case nomatch
        
    }
    static func playSound(_ effect:SoundEffect){
        
        var soundFilename = ""
        
        switch effect {
        
        case .flip:
            soundFilename = "cardflip"
        
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find soun file \(soundFilename) in the bundle.")
            return
        }
        
        //Create a URL for this string path
        //we can force unwrap, becuase we know if we got this far bundlePath is here, becuase of the guard statement
        //right above
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
            //Create AudioPlayer object
            // AVAudioPlayer has a "throws" method so we have to do a "do catch" to catch the possible error
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //Play the sound
            audioPlayer?.play()
        }
        catch{
            //Couldn't create the audio player object, log the error
            print("Couldn't create the audio player object for sound file \(soundFilename)")
        }
    }//EOF playSound
}

