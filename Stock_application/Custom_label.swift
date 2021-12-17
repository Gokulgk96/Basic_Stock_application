//
//  Custom_label.swift
//  Stock_application
//
//  Created by Gokul Gopalakrishnan on 13/10/21.
//

import UIKit

class Custom_label: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    
    
    func setup()
    {
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.textAlignment = .center
   
    }
}
