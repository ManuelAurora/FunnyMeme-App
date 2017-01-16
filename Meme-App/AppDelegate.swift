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
    func setupTextAttributes(_ textSize: CGFloat) -> [String: NSObject] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textAttributes = [
            NSFontAttributeName:            UIFont(name: "HelveticaNeue-CondensedBlack", size: textSize)!,
            NSStrokeWidthAttributeName:     -6.0,
            NSParagraphStyleAttributeName:  paragraphStyle,
            NSStrokeColorAttributeName:     UIColor.black,
            NSForegroundColorAttributeName: UIColor.white
        ] as [String : Any]
        
        return textAttributes as! [String : NSObject]
    }
    
     // MARK: *** Delegate functions ***
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

