//  DetailViewController.swift
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var meme        = Meme?()
    
    // MARK: *** Outlets ***
    @IBOutlet weak var imageView: UIImageView?    
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        imageView?.image = meme?.memedImage       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
