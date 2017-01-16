//  MemesCollectionViewController.swift
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UICollectionViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: *** Outlets ***
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    // MARK: *** Actions ***
    @IBAction func addNewMeme(_ sender: UIBarButtonItem) {
        let controller    = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        let navController = UINavigationController(rootViewController: controller)
        
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let space: CGFloat = 3.0
        let dimension      = (view.frame.size.width - (2 * space)) / 3
        
        flowLayout.itemSize                = CGSize(width: dimension, height: dimension)
        flowLayout.minimumLineSpacing      = space
        flowLayout.minimumInteritemSpacing = space
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let meme = appDelegate.memes[indexPath.row]
        controller.meme = meme
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

      
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meme", for: indexPath) as! MemeCollectionCollectionViewCell
     
        let meme = appDelegate.memes[indexPath.row]
        
        let topText    = NSAttributedString(string: meme.topText!,    attributes: appDelegate.setupTextAttributes(17))
        let bottomText = NSAttributedString(string: meme.bottomText!, attributes: appDelegate.setupTextAttributes(17))
        
        cell.memeImageView.image            = meme.image
        cell.memeTopLabel.attributedText    = topText
        cell.memeBottomLabel.attributedText = bottomText
    
        return cell
    }        
}
