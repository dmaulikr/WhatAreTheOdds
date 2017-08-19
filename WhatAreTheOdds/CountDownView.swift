//
//  countDownView.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 11/27/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import UIKit
import iAd

class CountDownView : GameViewController, ADBannerViewDelegate {
    
    //all the outlets for this view
    @IBOutlet var countView: UIView!
    @IBOutlet weak var connectionWarningLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var theirNumLabel: UILabel!
    @IBOutlet weak var theirNumSlider: UISlider!
    @IBOutlet weak var countDownButt: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    
    //some variables that we need
    var theirActualOdds = 13
    var reach = Reachability()
    var isNetwork = true
    var numberChosen = 0
    
    //runs when the view is created
    override func viewDidLoad() {
        //super.viewDidLoad()               //comment out so it doesnt get new view
        
        //set  the switch's according to saved stuff
        var soundSetting: Bool? = userDefaults.objectForKey("soundSetting") as Bool?
        if soundSetting != nil {
            soundIsOn = soundSetting!
            siriSpeak.soundIsOn = soundIsOn
        }
        var voiceSetting: Bool? = userDefaults.objectForKey("voiceSetting") as Bool?
        if voiceSetting != nil {
            voiceRecognitionIsOn = voiceSetting!
        }
        
        
        if !reach.isConnectedToNetwork() {
            isNetwork = false
        }
        
        if isNetwork && voiceRecognitionIsOn {               //network connection present
            println()
            println("You are connected to Network")
            println()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            countDownLabel.text = "\(Int(decramentor))"
            siriSpeak.siriSaysWord(String(Int(decramentor)))
            speachObject.theirOdds = Int32(theirActualOdds)
        } else {                                        //NO network connection
            println()
            println("You are not connected to Network")
            println()
            
            siriSpeak.siriSaysWord("Choose a number inbetween your chosen odds")
            //set up all the labels and buttons and things
            if voiceRecognitionIsOn {
                connectionWarningLabel.hidden = false
            }
            instructionsLabel.hidden = false
            theirNumLabel.hidden = false
            theirNumSlider.hidden = false
            theirNumSlider.enabled = true
            theirNumSlider.maximumValue = Float(theirActualOdds)
            countDownButt.hidden = false
            countDownButt.enabled = true
            
        }

    }
    
    //uses the timer for  the countdown
    func updateTimer(){
        if decramentor == 2.5 {
            siriSpeak.siriSaysWord(String(Int(decramentor)))
            decramentor -= 0.5
            countDownLabel.text = String(Int(decramentor))
            
        } else if decramentor == 1.5 {
            siriSpeak.siriSaysWord(String(Int(decramentor)))
            decramentor -= 0.5
            countDownLabel.text = String(Int(decramentor))
        } else if decramentor == 1 {
            //starts recognizing your words
            speachObject.speakingIsStarting()
            decramentor -= 0.5
        }
        else if decramentor == 0.5 {
            
            var randNum = String(oddString.getRandomNum(theirActualOdds))
            siriSpeak.siriSaysWord(randNum)
            countDownLabel.text = randNum
            countView.backgroundColor = UIColor.redColor()
            decramentor -= 0.5
            backGroundImage.hidden = true
            
            sirisNumber = randNum           //set siri's number for gameController
            
        } else if decramentor < -1.5 {
            speachObject.cancelListening()
            performSegueWithIdentifier("unwindToGameViewController", sender: self)
            timer.invalidate()
        } else {
            decramentor -= 0.5               //decrament to get to perform segue
        }
    }
    
    //display the number that is chosen
    @IBAction func sliderValueChanged(sender: AnyObject) {
        numberChosen = Int(theirNumSlider.value)
        self.theirNumLabel.text = "\(numberChosen)"
    }
    
    //go to the countdown
    @IBAction func countDownPushed(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        countDownLabel.text = "\(Int(decramentor))"
        siriSpeak.siriSaysWord(String(Int(decramentor)))
        speachObject.theirOdds = Int32(theirActualOdds)
        
        //hide all the labels and junk
        connectionWarningLabel.hidden = true
        instructionsLabel.hidden = true
        theirNumLabel.hidden = true
        theirNumSlider.hidden = true
        theirNumSlider.enabled = false
        countDownButt.hidden = true
        countDownButt.enabled = false
    }
    
    //prepares the text for next segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get the actual odds info
        if let doVC = segue.destinationViewController as? GameViewController {
            if isNetwork && voiceRecognitionIsOn {
                if speachObject.theirWords != nil {
                    doVC.usersNumber = speachObject.theirWords
                } else {
                    doVC.usersNumber = ""
                }
            } else {                                    //no network so pass this on
                doVC.usersNumber = "\(numberChosen)"
            }
            doVC.sirisNumber = sirisNumber
        }
    }
    
    ////////////////////////iAd
    //make the banner not show
    override func bannerViewDidLoadAd(banner: ADBannerView!){
        banner.hidden = true
    }
}