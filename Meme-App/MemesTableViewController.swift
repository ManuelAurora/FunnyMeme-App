//
//  MemesTableViewController.swift
//  Meme-App
//
//  Created by Мануэль on 19.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController
{

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate    
    
    @IBAction func addNewMeme(sender: UIBarButtonItem) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEdit") as! ViewController
        let navController = UINavigationController.init(rootViewController: controller)
        presentViewController(navController, animated: true, completion: nil)
    }
    
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = appDelegate.memes[indexPath.row]
        
        let topText    = NSAttributedString(string: meme.topText!, attributes: setupTextAttributes())
        let bottomText = NSAttributedString(string: meme.bottomText!, attributes: setupTextAttributes())
        
        
        cell.memeImageView.image = meme.image
        cell.memeTopLabel.attributedText = topText
        cell.memeBottomLabel.attributedText = bottomText
        cell.memeTitleLabel.text = "\(meme.topText!) \(meme.bottomText!)"
        
        return cell
    }
    
    
    func setupTextAttributes() -> [String: NSObject] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        
        let textAttributes = [
            NSFontAttributeName:            UIFont(name: "HelveticaNeue-CondensedBlack", size: 14)!,
            NSStrokeWidthAttributeName:     -6.0,
            NSParagraphStyleAttributeName:  paragraphStyle,
            NSStrokeColorAttributeName:     UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        return textAttributes
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
