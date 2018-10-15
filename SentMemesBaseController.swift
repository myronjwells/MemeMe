//
//  SentMemesBaseController.swift
//  MemeMe
//
//  Created by Wells, Myron on 9/4/18.
//  Copyright © 2018 Myron Wells. All rights reserved.
//

import UIKit

class SentMemesBaseController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes = [Meme]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        memes = appDelegate.memes
        
        let addMemesButton = UIBarButtonItem(barButtonSystemItem:.add, target: self, action:#selector(addMemes))
        self.navigationItem.rightBarButtonItem  = addMemesButton
    }
    

    @objc private func addMemes() {

       performSegue(withIdentifier: "addMemesSegue", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "previewMemeTableViewSegue" || segue.identifier == "previewMemeCollectionViewSegue") {
            
            let memePreviewVC = segue.destination as! MemePreviewViewController
            
            memePreviewVC.selectedMeme = sender as! Meme
            
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
