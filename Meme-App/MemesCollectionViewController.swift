//
//  MemesCollectionViewController.swift
//  Meme-App
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UICollectionViewController
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    @IBAction func addNewMeme(sender: UIBarButtonItem) {
        let controller    = storyboard?.instantiateViewControllerWithIdentifier("MemeEdit") as! ViewController
        let navController = UINavigationController(rootViewController: controller)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
