//
//  CircleView.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/19/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation
import UIKit

class CircleView : UIView {
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 5.0)
        UIColor.redColor().set()
        UIColor.redColor().colorWithAlphaComponent(0.4).setFill()
        UIRectFill(rect)
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        CGContextStrokePath(context)
    }
}