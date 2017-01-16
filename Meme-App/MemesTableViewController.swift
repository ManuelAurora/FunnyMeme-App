//  MemesTableViewController.swift
//
//  Created by Мануэль on 19.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController
{
    // MARK: *** Variables ***
    let appDelegate = UIApplication.shared.delegate as! AppDelegate    
    
    // MARK: *** Actions ***
    @IBAction func addNewMeme(_ sender: UIBarButtonItem) {
        let controller    = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        let navController = UINavigationController.init(rootViewController: controller)
        
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(_ animated: Bool) {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableViewCell
        let meme = appDelegate.memes[indexPath.row]
        
        let topText    = NSAttributedString(string: meme.topText!,    attributes: appDelegate.setupTextAttributes(14))
        let bottomText = NSAttributedString(string: meme.bottomText!, attributes: appDelegate.setupTextAttributes(14))
        
        cell.memeImageView.image            = meme.image
        cell.memeTitleLabel.text            = "\(meme.topText!) ... \(meme.bottomText!)"
        cell.memeTopLabel.attributedText    = topText
        cell.memeBottomLabel.attributedText = bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        controller.meme = appDelegate.memes[indexPath.row]
       
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func editMeme() {
        
    }
}
