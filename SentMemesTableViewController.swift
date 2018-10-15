//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Wells, Myron on 8/23/18.
//  Copyright © 2018 Myron Wells. All rights reserved.
//

import UIKit

class SentMemesTableViewController: SentMemesBaseController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return memes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        cell?.imageView?.image = memes[indexPath.row].memedImage
        cell?.textLabel?.text = String(format: "%@ ... %@", memes[indexPath.row].topText,memes[indexPath.row].bottomText)
//        // Configure the cell...

        return cell!
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes.remove(at: indexPath.row)
            print(self.memes.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let memePreviewVC = MemePreviewViewController()
        let meme = memes[indexPath.row]
        //memePreviewVC.memePreview =
        performSegue(withIdentifier: "previewMemeTableViewSegue", sender: meme)
        
    }
}
