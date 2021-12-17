//
//  Stock_Display_ViewController.swift
//  Stock_application
//
//  Created by Gokul Gopalakrishnan on 13/10/21.
//

import UIKit

class Stock_Display_ViewController: UIViewController {

    @IBOutlet weak var Security_code: UILabel!
    @IBOutlet weak var issuer_name: UILabel!
    @IBOutlet weak var Security_id: UILabel!
    @IBOutlet weak var Security_name: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Group: UILabel!
    @IBOutlet weak var isin_no: UILabel!
    @IBOutlet weak var Face_value: UILabel!
    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var instrument: UILabel!
    
    var name = ""
    var count = 0
    var status_check : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        for i in Struct_Data
        {
            if i.Security_Id == name
            {
                break
            }else
            {
                count += 1
            }
        }
        if Struct_Data[count].Status == ""
        {
           status_check = "NIL"
        }
        else
        {
            status_check = Struct_Data[count].Status!
        }
       
        
        Security_code.text = String(Struct_Data[count].Security_Code)
        issuer_name.text = Struct_Data[count].Issuer_Name
        Security_id.text = Struct_Data[count].Security_Id
        Security_name.text = Struct_Data[count].Security
        Status.text = status_check
        Group.text = Struct_Data[count].Group
        isin_no.text = Struct_Data[count].ISIN_No
        Face_value.text = String(Struct_Data[count].Face_Value)
        industry.text = Struct_Data[count].Industry
        instrument.text = Struct_Data[count].Instrument
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Stock Protofolio"
    }

}
