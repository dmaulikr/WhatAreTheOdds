//
//  HowToViewController.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 12/17/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation
import UIKit

class HowToViewController : ViewController, UIPageViewControllerDataSource {
    
    private var pageViewController: UIPageViewController?
    
    private let contentImages = ["IntroPic", "GetDarePic", "RangePic", "TapButtPic", "CountDownPic", "ScoresPic", "SiriScoresPic", "YouScorePic", "WinnerPic"]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        if !siriSpeak.isSiriSpeaking() {
            siriSpeak.siriSaysWord("Hello, my name is Siri. I am your enemy. You are playing against me in What Are The Odds. I would recommend that you get a group of friends and pass around the mobile device so multiple people have the change to get wooped by me. What Are The Odds is basically a Dare Game. You choose the odds that you will have to do the dare. If we say the same number, which must be in the range you specify, you have to do the dare. Otherwise you get points. The first one of us to get to 15 points wins. But of coarse I will most likely win!")
        }
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    //implement UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as PageItemController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    //Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        siriSpeak.stopSpeaking()
    }

}