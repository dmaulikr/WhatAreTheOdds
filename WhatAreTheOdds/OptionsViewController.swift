//
//  OptionsViewController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/28/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController : ViewController {
    
    @IBOutlet weak var menuButt: UIView!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var voiceSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the appppearance of the switches
        soundSwitch.on = soundIsOn
        voiceSwitch.on = voiceRecognitionIsOn
        
    }
    
    @IBAction func sounderWasSwitched(sender: AnyObject) {
        soundIsOn = soundSwitch.on
        
        //save the settings
        let soundSetting = soundSwitch.on
        userDefaults.setObject(soundSetting, forKey: "soundSetting")
        userDefaults.synchronize()
    }
    
    @IBAction func soundWasSwitched(sender: AnyObject) {
        voiceRecognitionIsOn = voiceSwitch.on
        
        //save the settings
        let voiceSetting = voiceSwitch.on
        userDefaults.setObject(voiceSetting, forKey: "voiceSetting")
        userDefaults.synchronize()
    }
    
    @IBAction func tappedMenuButt(sender: AnyObject) {
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
    
    
}