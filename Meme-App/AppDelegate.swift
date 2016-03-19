//  AppDelegate.swift
//
//  Created by Мануэль on 17.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    // MARK: *** Variables ***
    var window: UIWindow?
    var memes = [Meme]()
    
     // MARK: *** Functions ***
    func setupTextAttributes(textSize: CGFloat) -> [String: NSObject] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        
        let textAttributes = [
            NSFontAttributeName:            UIFont(name: "HelveticaNeue-CondensedBlack", size: textSize)!,
            NSStrokeWidthAttributeName:     -6.0,
            NSParagraphStyleAttributeName:  paragraphStyle,
            NSStrokeColorAttributeName:     UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        return textAttributes
    }
    
     // MARK: *** Delegate functions ***
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
}

