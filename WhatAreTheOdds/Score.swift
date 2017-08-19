//
//  Score.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/26/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation

class Score {
    
    //variables for the class
    var siriScore = Int()
    var userScore = Int()
    var siriTalks = SiriSpeaks()
    var soundIsOn = true
    
    //initializer
    init(sScore: Int, uScore: Int) {
        siriScore = sScore
        userScore = uScore
    }
    
    //for NSUserDefaults
    init(coder aDecoder:NSCoder!) {
        self.siriScore = aDecoder.decodeObjectForKey("siriScore") as Int
        self.userScore = aDecoder.decodeObjectForKey("userScore") as Int
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Score {
        self.siriScore = aDecoder.decodeObjectForKey("siriScore") as Int
        self.userScore = aDecoder.decodeObjectForKey("userScore") as Int
        
        return self
    }
    
    func encodeWithCoder(aCoder:NSCoder!) {
        aCoder.encodeObject(siriScore, forKey: "siriScore")
        aCoder.encodeObject(userScore, forKey: "userScore")
    }
    
    func calculateScore(sirisNumber:String, usersNumber:String, difference:Int) -> String {
        //convert 2 strings to ints
        let siriNum:Int? = sirisNumber.toInt()
        let userNum:Int? = usersNumber.toInt()
        if siriNum == userNum {             //siri got points
            siriScore += 5
            if self.siriScore >= 15 {
                return "doDareThenSiriWins"
            }
            return "userHasToDoDare"
        } else {
            siriTalks.soundIsOn = soundIsOn             //make it only talk if the settings say so
            if difference > 10 {            //siri gets points
                siriScore += 5
                siriTalks.siriSaysWord("I gained 5 points, hahaha you shall lose!")
            } else if difference > 5 {
                siriScore += 3
                siriTalks.siriSaysWord("I gained 3 points")
            } else if difference > 0 {
                siriScore += 1
                siriTalks.siriSaysWord("I gained 1 point")
            } else if difference < -10 {    //user gets points
                userScore += 5
                siriTalks.siriSaysWord("You gained 5 points, think you can beat me or something?")
            } else if difference < -5 {
                userScore += 3
                siriTalks.siriSaysWord("You gained 3 points")
            } else if difference < 0 {
                userScore += 1
                siriTalks.siriSaysWord("You gained 1 point")
            }
        }
        if self.siriScore >= 15 {
            return "siriWins"
        } else if self.userScore >= 15 {
            return "userWins"
        }
        return "pointsAreAwarded"
    }
    
}