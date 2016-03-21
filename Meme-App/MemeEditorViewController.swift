//  MemeEditorViewController
//
//  Created by Мануэль on 17.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    
    // MARK: *** Variables ***
    let imagePickerController = UIImagePickerController()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var editMeme         = false
    var topTextActivated = false
  
       
    // MARK: *** Outlets ***
    @IBOutlet weak var toolBar:         UIToolbar!
    @IBOutlet weak var imageView:       UIImageView?
    @IBOutlet weak var albumButton:     UIBarButtonItem!
    @IBOutlet weak var topTextField:    UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var topText = ""
    var bottomText = ""
    var image = UIImage()
    
    // MARK: *** Actions ***
    @IBAction func shareMeme(sender: AnyObject) {
        
        var meme = Meme()
        meme.image      = imageView?.image
        meme.topText    = topTextField.text
        meme.bottomText = bottomTextField.text
        
        let memedImage = generateMemedImage()
        
        meme.memedImage = memedImage
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems:[AnyObject]?, error: NSError?) in
            if completed {
                self.appDelegate.memes.append(meme)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
   
    @IBAction func cancel(sender: UIBarButtonItem) {
        imageView?.image = nil
        defaultText()
        navigationItem.leftBarButtonItem?.enabled = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickImage(sender: UIBarButtonItem) {        
      
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePickerController.sourceType = .Camera
            albumButton.enabled = true
        } else {
            imagePickerController.sourceType = .PhotoLibrary
            albumButton.enabled = false
        }
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureButtons()
        subscribeToKeyboardNotification()      
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeToKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editMeme {
            hideToolBar(true)
        }
        
        imageView?.image = image
       
        configureNavBar(editMeme ? true : false)
        configureToolBar()
        setupTextAttributes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: *** Notification functions ***
    func subscribeToKeyboardNotification() {
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: ***Auxiliary functions ***
    func generateMemedImage() -> UIImage {
        
        hideNavBar(true)
        hideToolBar(true)
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        hideNavBar(false)
        hideToolBar(false)
        
        return memedImage
    }
    
    func setupTextAttributes() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        
        let textAttributes = [
            NSFontAttributeName:            UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName:     -6.0,
            NSParagraphStyleAttributeName:  paragraphStyle,
            NSStrokeColorAttributeName:     UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]        
        
        topTextField.defaultTextAttributes    = textAttributes
        bottomTextField.defaultTextAttributes = textAttributes
        
        defaultText()
    }
    
    func configureNavBar(LeftButtonEnabled: Bool = false) {
        navigationController?.navigationBar.frame.size.height = toolBar.frame.size.height
        navigationController?.navigationBar.translucent = true
        self.navigationItem.leftBarButtonItem?.enabled  = LeftButtonEnabled
    }
    
    func configureToolBar() {
       toolBar.translucent = true
    }
    
    func configureButtons() {
        albumButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func hideNavBar(hidden: Bool) {
        navigationController?.navigationBarHidden = hidden
    }
    
    func hideToolBar(hidden: Bool) {
        toolBar.hidden = hidden
    }
    
    func defaultText() {
        
        if !editMeme {
        topText = "TOP"
        bottomText = "BOTTOM"
        }
        
        topTextField.text    = topText
        bottomTextField.text = bottomText
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }
    
    // MARK: *** Keyboard manipulations ***
    func keyboardWillShow(notification: NSNotification) {
        if !topTextActivated {
        view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
           }
    
    func keyboardWillHide(notification: NSNotification) {
        if !topTextActivated {
        view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: *** Delegate methods ***
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            imageView?.image = image
            configureNavBar(true)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" { textField.text = "" }
        if textField == topTextField { topTextActivated = true }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        topTextActivated = false
        return true
    }
}

