//
//  YouLostViewController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/26/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation
import UIKit

class YouLostViewController : GameViewController {
    
    
    var siriScoreFinal = 0
    var userScoreFinal = 0
    
    override func viewDidLoad() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("checkTimer4"), userInfo: nil, repeats: true)             //set the timer
        
        //set score information back to 0
        let encodedSiriScore = NSKeyedArchiver.archivedDataWithRootObject(0)
        let encodedUserScore = NSKeyedArchiver.archivedDataWithRootObject(0)
        
        var encodedArray: [NSData] = [encodedSiriScore, encodedUserScore]
        userDefaults.setObject(encodedArray, forKey: "scoreItem")
        
        //reset the result text
        let resultsText = ""
        userDefaults.setObject(resultsText, forKey: "resultText")
        
        //set the text back to nothing
        let oddsText = ""
        userDefaults.setObject(oddsText, forKey: "oddsText")
        
        //save the theyHitOdds var of what numbers where chosen
        userDefaults.setObject(false, forKey: "theyHitOdds")
        
        userDefaults.synchronize()          //save all now
    }
    
    func checkTimer4() {
        if !siriSpeak.isSiriSpeaking() {                        //checks if siri is still speaking
            siriSpeak.siriSaysWord("Hahaha, I beat you!")
            timer.invalidate()
        }
    }

}