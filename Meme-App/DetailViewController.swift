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
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var meme = Meme?()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        imageView?.image = meme?.memedImage       
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
