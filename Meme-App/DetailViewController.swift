//  DetailViewController.swift
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var meme: Meme?
    
    // MARK: *** Outlets ***
    @IBOutlet weak var imageView: UIImageView?    
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        imageView?.image = meme?.memedImage       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editMeme(_ sender: UIBarButtonItem) {
        
        let controller =      storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        let navController = UINavigationController.init(rootViewController: controller)        
        
        controller.editMeme = true
        controller.image = meme!.image!
        controller.topText = meme!.topText!
        controller.bottomText = meme!.bottomText!
        
        present(navController, animated: true, completion: nil)
        
      }
}
