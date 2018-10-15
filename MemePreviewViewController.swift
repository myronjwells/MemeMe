//
//  MemePreviewViewController.swift
//  MemeMe
//
//  Created by Wells, Myron on 9/7/18.
//  Copyright © 2018 Myron Wells. All rights reserved.
//

import UIKit

class MemePreviewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    //var memePreview = UIImage()
    var selectedMeme : Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         self.imageView.image = selectedMeme.memedImage
    }

    @IBAction func editMeme(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "editMemeSegue", sender: nil)
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editMemeSegue") {
            
            let mainViewController = segue.destination as! ViewController
            
            mainViewController.isEditingMeme = true
            mainViewController.selectedMemeToEdit = selectedMeme
            
            
        }
    }
    

}
