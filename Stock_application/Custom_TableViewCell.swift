//
//  Custom_TableViewCell.swift
//  Stock_application
//
//  Created by Gokul Gopalakrishnan on 11/10/21.
//

import UIKit

class Custom_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Security_name: UILabel!
    
    
    @IBOutlet weak var Security_Id: UILabel!
   

    
    
    func set(Security_Name: String, Security_id: String)
    {
        Security_name.text = Security_Name
        
        Security_Id.text = Security_id
        
        self.backgroundColor = #colorLiteral(red: 0.8898823857, green: 0.7627489567, blue: 0.2003419399, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        
    
    }

}
