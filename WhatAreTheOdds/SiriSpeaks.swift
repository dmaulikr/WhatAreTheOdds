//
//  SiriSpeaks.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 11/25/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation
import AVFoundation

public class SiriSpeaks {
    
    var odds = FileForOdds()
    var mySpeechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    var difference = 0
    var soundIsOn = true
    
    public var currentOdds:String = "yuck"
    
    //func for siri saying any string you want
    func siriSaysWord(word:String){
        if soundIsOn {                                          //if the sound is on from settings
            var anotherSpeechUtterance:AVSpeechUtterance = AVSpeechUtterance(string:word)
            anotherSpeechUtterance.rate = 0.1
            mySpeechSynthesizer.speakUtterance(anotherSpeechUtterance)
        }
    }
    
    //this are the actual dares that siri says
    func getSiriToSayOdds() {
        currentOdds = odds.getRandomStringForOdds()
        self.siriSaysWord(currentOdds)
    }
    
    //this fuc stops siri's speaking
    func stopSpeaking() {
        mySpeechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Word)
    }
    
    //is Siri speaking?
    public func isSiriSpeaking() -> Bool {
        return mySpeechSynthesizer.speaking
    }
    
    //siri says these things when she is upset at you for pushing a wrong button
    func siriSayingNo() {
        var siriSaysNo = ["Oh I see, dont want to do those odds?",
                            "ummm aren't you forgetting something?",
                            "you can't get away with that",
                            "you have to do the odds, silly!",
                            "ughhhh, thats a no no!",
                            "You have to touch the go button"]
        
        var randomChoice = siriSaysNo[odds.getRandomNumStartingAt0(siriSaysNo.count)]
        self.siriSaysWord(randomChoice)
    }
    
    //siri tells you that you need to choose a new dare
    func siriSaysPickNewDare() {
        var siriSaysPick = ["What? scared to see what the next dare is?",
            "you already did that!",
            "You have to get a new dare",]
        
        var randomChoice = siriSaysPick[odds.getRandomNumStartingAt0(siriSaysPick.count)]
        self.siriSaysWord(randomChoice)
    }
    
    //siri talks about the user having to do a dare
    func siriTalksAboutUserDoingDare() {
        var siriSaysStuff = ["Yikes! someone has to do the dare!",
            "We said the same number! You have to do the dare!",
            "Looks like some one is about to be embarrassed! becuase you have to do the dare",
            "I am awarded 5 points because you have to do the dare!",
            "It looks like someone is about to do the dare!",
            "hahaha, thats what I am gonna do when I see you do this dare!",
            "haha you have to do the dare! you poor human!"]
        
        var randomChoice = siriSaysStuff[odds.getRandomNumStartingAt0(siriSaysStuff.count)]
        self.siriSaysWord(randomChoice)
    }
    
    //siri says if she likes your choice for odds or not
    func siriTalksAboutExpectedOdds(theirOdds:Int) -> Bool {                 //returns true if siri spoke
        difference = odds.getExpectedOddsDifferenceFromTheirOdds(theirOdds)
        if difference > 7 {
            var siriSaysBad = ["You can do better than that",
                "is that all you got!?",
                "those odds are way to high",
                "that is lame!",
                "you really don't like this one do you",
                "What? are you scared?"]
            var randomChoice = siriSaysBad[odds.getRandomNumStartingAt0(siriSaysBad.count)]
            self.siriSaysWord(randomChoice)
            return true
            
        } else if difference < -6 {
            var siriSaysGood = ["wow! good job!",
                "The chances are high!",
                "I like this!",
                "You must want to do this one!",
                "You make me smile!",
                "Those are such good odds that I almost want to cry!"]
            var randomChoice = siriSaysGood[odds.getRandomNumStartingAt0(siriSaysGood.count)]
            self.siriSaysWord(randomChoice)
            return true
        }
        return false
    }
    
}