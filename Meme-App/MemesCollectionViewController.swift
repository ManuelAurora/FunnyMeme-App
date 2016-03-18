//
//  MemesCollectionViewController.swift
//  Meme-App
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemesCollectionViewController: UICollectionViewController
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()     
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

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("meme", forIndexPath: indexPath) as! MemeCollectionCollectionViewCell
     
        let meme = appDelegate.memes[indexPath.row]
        
        cell.image      = meme.image
        cell.topText    = meme.topText
        cell.bottomText = meme.bottomText
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("DetailInfo") as! DetailViewController
        let cell = appDelegate.memes[indexPath.row]
        
        controller.imageView.image = cell.image
        controller.topTextField.text = cell.topText
        controller.bottomTextField.text = cell.bottomText
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
