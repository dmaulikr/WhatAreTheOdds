//
//  GameViewController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 11/25/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import UIKit
import iAd

class GameViewController : ViewController, ADBannerViewDelegate {
    
    ///////////////////////outlets
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var oddsSlider: UISlider!
    @IBOutlet weak var oddsNumLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var siriScoreLabel: UILabel!
    @IBOutlet weak var menuButt: UIView!
    @IBOutlet weak var goToCountButt: UIView!
    @IBOutlet weak var goToCountLabel: UILabel!
    @IBOutlet weak var getDareButt: UIView!
    
    ///////////////////////variables
    var timer = NSTimer()
    var decramentor:Float = 3
    var theyhitOddsAlready:Bool = false
    var sirisNumber = ""
    var usersNumber = ""
    var difference = Int()
    var scoreObject = Score(sScore: 0, uScore: 0)
    
    //action when the user touches the random odds button
    @IBAction func tappedGetDare(sender: AnyObject) {
        
        // angles in iOS are measured as radians PI is 180 degrees so PI × 2 is 360 degrees
        let fullRotation = CGFloat(M_PI * 2)
        let duration = 0.6
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
                
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
                    
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.getDareButt.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.getDareButt.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.getDareButt.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
            })
                    
            }, completion: {finished in
                //do the stuff of the button
                if self.theyhitOddsAlready {
                    if !self.siriSpeak.isSiriSpeaking() {
                        self.siriSpeak.siriSayingNo()
                    }
                } else {
                    self.siriSpeak.getSiriToSayOdds()
                    self.oddsLabel.alpha = 0.0                                   //set alpha to 0 for fade
                    self.oddsLabel.text = self.siriSpeak.currentOdds
                    self.theyhitOddsAlready = true
                    
                    UIView.animateWithDuration(1.0, animations: {           //make label fade in
                        self.oddsLabel.alpha = 1.0
                    })
                    
                    //save the theyHitOdds var of what numbers where chosen
                    self.userDefaults.setObject(self.theyhitOddsAlready, forKey: "theyHitOdds")
                    
                    //save the odds label of what string was said
                    let oddsText = self.oddsLabel.text
                    self.userDefaults.setObject(oddsText, forKey: "oddsText")
                    self.userDefaults.synchronize()
                }

        })
    }
    
    
    //action when the slider is moved
    @IBAction func sliderMoved(sender: AnyObject) {
        oddString.theirOdds = Int(oddsSlider.value)
        self.oddsNumLabel.text = "\(oddString.theirOdds)"
    }
    
    //when the go button is touched
    @IBAction func tappedGoToCount(sender: AnyObject) {
        
        //button animation
        var originalFrame = goToCountButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.goToCountButt.frame = CGRectMake(self.goToCountButt.frame.origin.x + 5, self.goToCountButt.frame.origin.y + 5, self.goToCountButt.frame.size.width - 10, self.goToCountButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.goToCountButt.frame = originalFrame
            },
            completion: nil)
        
        
        //stuff it does
        if theyhitOddsAlready {             //only runs if they hit the get dare butt already
            theyhitOddsAlready = false
            //save the theyHitOdds var of what numbers where chosen
            userDefaults.setObject(theyhitOddsAlready, forKey: "theyHitOdds")
            userDefaults.synchronize()
            
            if siriSpeak.siriTalksAboutExpectedOdds(oddString.theirOdds) {
                timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("checkTimer"), userInfo: nil, repeats: true)             //set the timer
            } else{
                performSegueWithIdentifier("toCountDownView", sender: self)
            }
            
        } else {
            if !siriSpeak.isSiriSpeaking(){
                siriSpeak.siriSaysPickNewDare()
            }
        }
    }
    
    //segues when timer reaches limit
    func checkTimer() {
        if !siriSpeak.isSiriSpeaking() {                        //checks if siri is still speaking
            performSegueWithIdentifier("toCountDownView", sender: self)
            timer.invalidate()
        }
    }
    
    //segues when timer reaches limit
    func checkTimer2() {
        if !siriSpeak.isSiriSpeaking() {                        //checks if siri is still speaking
            performSegueWithIdentifier("toYouWinView", sender: self)
            timer.invalidate()
        }
    }
    
    //segues when timer reaches limit
    func checkTimer3() {
        if !siriSpeak.isSiriSpeaking() {                        //checks if siri is still speaking
            performSegueWithIdentifier("toYouLostView", sender: self)
            timer.invalidate()
        }
    }
    
    //action for hitting menu button
    @IBAction func tappedMenu(sender: AnyObject) {
        var originalFrame = menuButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.menuButt.frame = CGRectMake(self.menuButt.frame.origin.x + 5, self.menuButt.frame.origin.y + 5, self.menuButt.frame.size.width - 10, self.menuButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.menuButt.frame = originalFrame
            },
            completion: {(ugh:Bool) in
                self.dismissViewControllerAnimated(true, completion: nil)
        }   )
    }
    
    //create the circle View
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        //set score according to saved score stuff
        var scoreDataEncoded: [NSData] = userDefaults.objectForKey("scoreItem") as [NSData]
        
        scoreObject.siriScore = NSKeyedUnarchiver.unarchiveObjectWithData(scoreDataEncoded[0] as NSData) as Int
        scoreObject.userScore = NSKeyedUnarchiver.unarchiveObjectWithData(scoreDataEncoded[1] as NSData) as Int
        siriScoreLabel.text = "Siri Score: \(scoreObject.siriScore)"            //set the labels
        userScoreLabel.text = "Your Score: \(scoreObject.userScore)"
        
        //set results label according to saved stuff
        var resultsText: String? = userDefaults.objectForKey("resultText") as String?
        if resultsText != nil {
            resultsLabel.text = resultsText
        }
        
        //set  oddslabel according to saved stuff
        var oddsText: String? = userDefaults.objectForKey("oddsText") as String?
        if oddsText != nil {
            oddsLabel.text = oddsText
        }
        
        //set  thehitOdds according to saved stuff
        var theyHitOdds: Bool? = userDefaults.objectForKey("theyHitOdds") as Bool?
        if theyHitOdds != nil {
            theyhitOddsAlready = theyHitOdds!
        }
        
        //set the sound setting for score
        scoreObject.soundIsOn = soundIsOn

    }
    
    //used for the exit segue
    @IBAction func unwindToGameViewController(sender:UIStoryboardSegue) {
        //empty for now
        if usersNumber == "" {                                      //siri doesnt know what you said
            siriSpeak.siriSaysWord("Im confused, say it again")
            resultsLabel.text = "Im confused, say it again"
            theyhitOddsAlready = true                             //make it so they can do it again
            goToCountLabel.text = "Go Again"
            //save the theyHitOdds var of what numbers where chosen
            userDefaults.setObject(theyhitOddsAlready, forKey: "theyHitOdds")
            userDefaults.synchronize()
        } else if countElements(usersNumber) < 3 {                  //someone scored
            resultsLabel.text = "Your #: \(usersNumber)          Siri's #: \(sirisNumber)"
            
            //save new score and say stuff about it
            let optionString = scoreObject.calculateScore(sirisNumber, usersNumber: usersNumber, difference: siriSpeak.difference)
            
            switch optionString {
            case "userHasToDoDare":
                siriSpeak.siriTalksAboutUserDoingDare()
                siriScoreLabel.text = "Siri's Score: \(scoreObject.siriScore)"
            case "siriWins":
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("checkTimer3"), userInfo: nil, repeats: true)
                siriScoreLabel.text = "Siri's Score: \(scoreObject.siriScore)"
                userScoreLabel.text = "Your Score: \(scoreObject.userScore)"
            case "doDareThenSiriWins":
                siriSpeak.siriTalksAboutUserDoingDare()
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("checkTimer3"), userInfo: nil, repeats: true)
                siriScoreLabel.text = "Siri's Score: \(scoreObject.siriScore)"
                userScoreLabel.text = "Your Score: \(scoreObject.userScore)"
            case "userWins":
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("checkTimer2"), userInfo: nil, repeats: true)
                siriScoreLabel.text = "Siri's Score: \(scoreObject.siriScore)"
                userScoreLabel.text = "Your Score: \(scoreObject.userScore)"
            case "pointsAreAwarded":
                siriScoreLabel.text = "Siri's Score: \(scoreObject.siriScore)"
                userScoreLabel.text = "Your Score: \(scoreObject.userScore)"
            default:
                println("default")
            }
            goToCountLabel.text = "Go"
            
            //save score information
            let encodedSiriScore = NSKeyedArchiver.archivedDataWithRootObject(scoreObject.siriScore)
            let encodedUserScore = NSKeyedArchiver.archivedDataWithRootObject(scoreObject.userScore)
            
            var encodedArray: [NSData] = [encodedSiriScore, encodedUserScore]
            userDefaults.setObject(encodedArray, forKey: "scoreItem")
            userDefaults.synchronize()
            
        } else {                                                    //siri didn't know what you said
            siriSpeak.siriSaysWord(usersNumber)
            resultsLabel.text = usersNumber
            goToCountLabel.text = "Go Again"
            theyhitOddsAlready = true                               //make it so they can do it again
            
            //save the theyHitOdds var of what numbers where chosen
            userDefaults.setObject(theyhitOddsAlready, forKey: "theyHitOdds")
            userDefaults.synchronize()
        }
        
        //save the results label of what numbers where chosen
        let resultsText = resultsLabel.text
        userDefaults.setObject(resultsText, forKey: "resultText")
        userDefaults.synchronize()
        
    }
    @IBAction func unwindToGameViewControllerFromEndGame(sender:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //prepares for the countDown seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get the actual odds info
        if segue.identifier == "toCountDownView" {
            if let doVC = segue.destinationViewController as? CountDownView {
                doVC.theirActualOdds = oddString.theirOdds
            }
        } else if segue.identifier == "toYouWonView" {
            if let myVC = segue.destinationViewController as? YouWonViewController {
                myVC.userScoreFinal = scoreObject.userScore
                myVC.siriScoreFinal = scoreObject.siriScore
            }
        }
    }
    
    //make it so that Siri stops talking
    override func viewWillDisappear(animated: Bool) {
        siriSpeak.stopSpeaking()
    }
}