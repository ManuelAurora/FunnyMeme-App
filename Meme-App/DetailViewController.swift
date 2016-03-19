//
//  DetailViewController.swift
//  Meme-App
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var topTextLabel: UILabel?
    @IBOutlet weak var bottomTextLabel: UILabel?
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var meme = Meme?()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let topText    = NSAttributedString(string: meme!.topText!, attributes: appDelegate.setupTextAttributes(40))
        let bottomText = NSAttributedString(string: meme!.bottomText!, attributes: appDelegate.setupTextAttributes(40))
        
        imageView?.image = meme?.image
        topTextLabel?.attributedText = topText
        bottomTextLabel?.attributedText = bottomText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
