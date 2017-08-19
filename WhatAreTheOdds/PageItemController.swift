//
//  PageItemController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 1/7/15.
//  Copyright (c) 2015 NoahBragg. All rights reserved.
//

import Foundation
import UIKit

class PageItemController: ViewController {
    
    @IBOutlet weak var menuButt: UIView!
    
    
    @IBOutlet weak var contentImageView: UIImageView?
    
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
    }
    @IBAction func touchedMenuButt(sender: AnyObject) {
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
        /*siriSpeak.stopSpeaking()                //stops the speaking
        siriSpeak.stopSpeaking()
        siriSpeak.stopSpeaking()
        siriSpeak.stopSpeaking()
        siriSpeak.stopSpeaking()
        siriSpeak.stopSpeaking()
        siriSpeak.stopSpeaking()*/
    }
}
