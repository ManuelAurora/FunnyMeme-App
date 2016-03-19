//  MemesTableViewController.swift
//
//  Created by Мануэль on 19.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate    
    
    // MARK: *** Actions ***
    @IBAction func addNewMeme(sender: UIBarButtonItem) {
        let controller    = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        let navController = UINavigationController.init(rootViewController: controller)
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        tableView.rowHeight = 90
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = appDelegate.memes[indexPath.row]
        
        let topText    = NSAttributedString(string: meme.topText!,    attributes: appDelegate.setupTextAttributes(14))
        let bottomText = NSAttributedString(string: meme.bottomText!, attributes: appDelegate.setupTextAttributes(14))
        
        cell.memeImageView.image            = meme.image
        cell.memeTitleLabel.text            = "\(meme.topText!) ... \(meme.bottomText!)"
        cell.memeTopLabel.attributedText    = topText
        cell.memeBottomLabel.attributedText = bottomText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {        
        let controller = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        controller.meme = appDelegate.memes[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }  
}
