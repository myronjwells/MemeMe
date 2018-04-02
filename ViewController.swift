//
//  ViewController.swift
//  MemeMe
//
//  Created by Myron Wells on 3/31/18.
//  Copyright © 2018 Myron Wells. All rights reserved.
//

import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var toolBars: [UIToolbar]!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraPicker: UIBarButtonItem!
    @IBOutlet weak var topTextField: MemeMeTextField!
    @IBOutlet weak var bottomTextField: MemeMeTextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the ui initally
        defaultUISetup()
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraPicker.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

             subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch sender.tag {
        case 1: //Camera Button
            imagePicker.sourceType = .camera
        case 2: //PhotoLibrary
            imagePicker.sourceType = .photoLibrary
        default: break
            
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //Share Meme Image
    @IBAction func share(_ sender: Any) {
        
        //generate a memed image
        let memedImage = generateMemedImage()
        
        //define an instance of the ActivityViewController
        //pass the ActivityViewController a memedImage as an activity item
        let activityViewController = UIActivityViewController(activityItems:[memedImage], applicationActivities: nil)
        
        //present the ActivityViewController
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            self.save()
        }
    }
    
    
    @IBAction func cancelEdit(_ sender: Any) {
        
        //Revert the UI back to default
        defaultUISetup()
        
        //Remove the chosen image
        imageView.image = nil
    }
    
    
    //Save Meme Image
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, self, nil, nil)
    }
    
    func defaultUISetup() {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
    }
    
    func generateMemedImage() -> UIImage {
        
        for toolbar in self.toolBars {
            
            toolbar.isHidden = true
        }
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        for toolbar in self.toolBars {
            
            toolbar.isHidden = false
        }
        
        return memedImage
    }
    
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if(self.bottomTextField.isFirstResponder) {
            
            //move the view up depending on the size of the keyboard
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide() {
        
        //move the view back to the top
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //NSNotification Methods
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
         NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    
    

    // UIImagePickerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = image
            
            //showing share button
            shareButton.isEnabled = true
            
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //UITextFieldDelegate Methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       textField.clearsOnBeginEditing = true
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


}



