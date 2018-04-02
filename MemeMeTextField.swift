//
//  MemeMeTextField.swift
//  MemeMe
//
//  Created by Myron Wells on 4/1/18.
//  Copyright © 2018 Myron Wells. All rights reserved.
//

import UIKit

class MemeMeTextField: UITextField {

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        
        
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -4.0]
        
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = .center
    }
    
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
