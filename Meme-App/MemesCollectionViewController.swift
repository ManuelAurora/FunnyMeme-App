//  MemesCollectionViewController.swift
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UICollectionViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: *** Outlets ***
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    // MARK: *** Actions ***
    @IBAction func addNewMeme(sender: UIBarButtonItem) {
        let controller    = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        let navController = UINavigationController(rootViewController: controller)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let space: CGFloat = 3.0
        let dimension      = (view.frame.size.width - (2 * space)) / 3
        
        flowLayout.itemSize                = CGSizeMake(dimension, dimension)
        flowLayout.minimumLineSpacing      = space
        flowLayout.minimumInteritemSpacing = space
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        let meme = appDelegate.memes[indexPath.row]
        controller.meme = meme
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

      
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("meme", forIndexPath: indexPath) as! MemeCollectionCollectionViewCell
     
        let meme = appDelegate.memes[indexPath.row]
        
        let topText    = NSAttributedString(string: meme.topText!,    attributes: appDelegate.setupTextAttributes(17))
        let bottomText = NSAttributedString(string: meme.bottomText!, attributes: appDelegate.setupTextAttributes(17))
        
        cell.memeImageView.image            = meme.image
        cell.memeTopLabel.attributedText    = topText
        cell.memeBottomLabel.attributedText = bottomText
    
        return cell
    }        
}
