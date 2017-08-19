//
//  ViewController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 11/25/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import UIKit
import iAd



class ViewController: UIViewController, ADBannerViewDelegate {          //make sure to extend UIAplicationDelegate for iAd
    //buttons
    @IBOutlet weak var newGameButt: UIView!
    @IBOutlet weak var continueButt: UIView!
    @IBOutlet weak var howToButt: UIView!
    @IBOutlet weak var optionsButt: UIView!
    
    //declare the speech object
    let speachObject = Speak()
    let userDefaults = NSUserDefaults.standardUserDefaults()        //used to save the stuffs
    
    var siriSpeak = SiriSpeaks()
    var soundIsOn = true
    var voiceRecognitionIsOn = true
    var _oddString: FileForOdds! = nil
    var oddString: FileForOdds {
        get{
            if _oddString == nil {
                _oddString = FileForOdds()
            }
            return _oddString
        }
    }
    
    //create a segue transition
    let transitionManagerRightLeft = TransitionManagerRightLeft()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManagerRightLeft
        
        if segue.identifier == "toNewGameView" {
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
        
    }
    
    //used for the exit segue
    @IBAction func unwindToViewController(sender:UIStoryboardSegue) {
        //empty for now
    }
    
    //tap the new game button
    @IBAction func tapNewGame(sender: AnyObject) {
        var originalFrame = newGameButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.newGameButt.frame = CGRectMake(self.newGameButt.frame.origin.x + 5, self.newGameButt.frame.origin.y + 5, self.newGameButt.frame.size.width - 10, self.newGameButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.newGameButt.frame = originalFrame
            },
            completion: nil)
        performSegueWithIdentifier("toNewGameView", sender: self)
    }
    
    //tap the continue button
    @IBAction func tapContinue(sender: AnyObject) {
        var originalFrame = continueButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.continueButt.frame = CGRectMake(self.continueButt.frame.origin.x + 5, self.continueButt.frame.origin.y + 5, self.continueButt.frame.size.width - 10, self.continueButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.continueButt.frame = originalFrame
            },
            completion: nil)
        performSegueWithIdentifier("toGameView", sender: self)
    }
    
    //tap the how to play button
    @IBAction func tapHowTo(sender: AnyObject) {
        var originalFrame = howToButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.howToButt.frame = CGRectMake(self.howToButt.frame.origin.x + 5, self.howToButt.frame.origin.y + 5, self.howToButt.frame.size.width - 10, self.howToButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.howToButt.frame = originalFrame
            },
            completion: nil)
        performSegueWithIdentifier("toHowView", sender: self)
    }
    
    //tap the get options button
    @IBAction func tapOptions(sender: AnyObject) {
        var originalFrame = optionsButt.frame
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.optionsButt.frame = CGRectMake(self.optionsButt.frame.origin.x + 5, self.optionsButt.frame.origin.y + 5, self.optionsButt.frame.size.width - 10, self.optionsButt.frame.size.height - 10)
            },
            completion: nil)
        
        UIView.animateWithDuration(0.1,
            delay: 0.1,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                self.optionsButt.frame = originalFrame
            },
            completion: nil)
        performSegueWithIdentifier("toOptionsView", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var oddString = FileForOdds()
        oddString.theirOdds = 13
        loadAds()
        
        //set up the speech connection
        speachObject.setupSpeechKitConnection()
        
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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////iAd stuff
    func loadAds(){
        var adBannerView = ADBannerView(frame: CGRect.zeroRect)
        adBannerView.center = CGPoint(x: adBannerView.center.x, y: view.bounds.size.height - adBannerView.frame.size.height / 2)
        adBannerView.delegate = self
        adBannerView.alpha = 0
        view.addSubview(adBannerView)
    }
    
    //loading the banner
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        UIView.animateWithDuration(1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                banner.alpha = 1
            },
            completion: nil)
    }
    
    //banner had an error
    func bannerView(banner:ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        UIView.animateWithDuration(1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () in
                banner.alpha = 0
            },
            completion: nil)
    }
    
}

