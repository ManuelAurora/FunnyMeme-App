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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    @IBAction func shareMeme(_ sender: AnyObject) {
        
        var meme = Meme()
        meme.image      = imageView?.image
        meme.topText    = topTextField.text
        meme.bottomText = bottomTextField.text
        
        let memedImage = generateMemedImage()
        
        meme.memedImage = memedImage
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType, completed: Bool, returnedItems:[Any]?, error: Error?) in
            if completed {
                self.appDelegate.memes.append(meme)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
   
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        imageView?.image = nil
        defaultText()
        navigationItem.leftBarButtonItem?.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImage(_ sender: UIBarButtonItem) {        
      
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            albumButton.isEnabled = true
        } else {
            imagePickerController.sourceType = .photoLibrary
            albumButton.isEnabled = false
        }
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: *** Overrided functions ***
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureButtons()
        subscribeToKeyboardNotification()      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
       NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: ***Auxiliary functions ***
    func generateMemedImage() -> UIImage {
        
        hideNavBar(true)
        hideToolBar(true)
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        hideNavBar(false)
        hideToolBar(false)
        
        return memedImage
    }
    
    func setupTextAttributes() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textAttributes = [
            NSFontAttributeName:            UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName:     -6.0,
            NSParagraphStyleAttributeName:  paragraphStyle,
            NSStrokeColorAttributeName:     UIColor.black,
            NSForegroundColorAttributeName: UIColor.white
        ] as [String : Any]        
        
        topTextField.defaultTextAttributes    = textAttributes
        bottomTextField.defaultTextAttributes = textAttributes
        
        defaultText()
    }
    
    func configureNavBar(_ LeftButtonEnabled: Bool = false) {
        navigationController?.navigationBar.frame.size.height = toolBar.frame.size.height
        navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.leftBarButtonItem?.isEnabled  = LeftButtonEnabled
    }
    
    func configureToolBar() {
       toolBar.isTranslucent = true
    }
    
    func configureButtons() {
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func hideNavBar(_ hidden: Bool) {
        navigationController?.isNavigationBarHidden = hidden
    }
    
    func hideToolBar(_ hidden: Bool) {
        toolBar.isHidden = hidden
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
    func keyboardWillShow(_ notification: Notification) {
        if !topTextActivated {
        view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
           }
    
    func keyboardWillHide(_ notification: Notification) {
        if !topTextActivated {
        view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: *** Delegate methods ***
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            imageView?.image = image
            configureNavBar(true)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" { textField.text = "" }
        if textField == topTextField { topTextActivated = true }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        topTextActivated = false
        return true
    }
}

