//
//  ViewController.swift
//  Stock_application
//
//  Created by Gokul Gopalakrishnan on 09/10/21.
//

import UIKit

var Struct_Data = [Stocks_Array_data]()


class ViewController: UIViewController {
    @IBOutlet weak var text_field: UITextField!
    @IBOutlet weak var Table_view: UITableView!
    
    var query = ""
    var datas = [String]()
    var datas2 = [String]()
    var Dict = [String:String]()
    var Filtered_Data = [String]()
    var Filtered_Data2 = [String]()
    var Filtered = false
    var text_value: String?
    var pages_index = 10
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
      
        text_field.layer.cornerRadius = 20
        text_field.clipsToBounds = true
        
        Table_view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        Table_view.tableFooterView = UIView(frame: .zero)
        
        
        
        //------------------------------
        
        let fileLocation = Bundle.main.url(forResource: "Stock_Data", withExtension: "json")

        
guard let jsonData = fileLocation else{return}
guard let data = try? Data(contentsOf: jsonData) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else{return}
        
 

        for i in 0...json.count - 1
        {
            let value = json[i]
            
            let Security_Code  = value["Security Code"]
            let Issuer_Name = value["Issuer Name"]
            let Security_Id  = value["Security Id"] as! String
            let Security  = value["Security Name"] as! String
            let Status  = value["Status"]
            let Group  = value["Group"]
            let Face_Value = value["Face Value"] as! Double
            let ISIN_No  = value["ISIN No"]
            let Industry  = value["Industry"]
            let Instrument  = value["Instrument"]
          
    Struct_Data.append(Stocks_Array_data(Security_Code: Security_Code as! Int, Issuer_Name: Issuer_Name as! String,
        Security_Id: Security_Id,
        Security: Security ,
        Status: Status as! String?,
        Group: Group as! String,
        Face_Value: Int(Face_Value),
        ISIN_No: ISIN_No as! String,
        Industry: Industry as! String,
        Instrument: Instrument as! String))
        }
       Struct_Data.sort() { $0.Face_Value  > $1.Face_Value }
        Table_view.reloadData()
        
        
        for i in 0...json.count - 1
        {
            datas.append(Struct_Data[i].Security_Id)
            datas2.append(Struct_Data[i].Security)
            
        }
        
        for i in 0...datas.count - 1
        {
            Dict[datas[i]] = datas2[i]
        }
        
        
        //------------------------------
       
    }
    
}


extension ViewController : UITableViewDataSource ,UITextFieldDelegate, UITableViewDelegate, UIScrollViewDelegate
{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        Filtered_Data.removeAll()
        Filtered_Data2.removeAll()
        
        if let text = textField.text
        {
           text_value = text
           if (string == "")
           {
            query = text+string
            query.removeLast()
           }
           else
           {
           query = text+string
           }
            
        }
        
        for strings in Struct_Data
        {
            if  strings.Security_Id.starts(with: query.uppercased())
           {
                Filtered_Data.append(strings.Security_Id)
                Filtered_Data2.append(strings.Security)
           }
            pages_index = 10
           
        }
   
        Filtered = true
   
    
        
        if(query.count == 1 && text_value!.count == 1 && string.count == 0)
        {
            Filtered = false
        }
        
       Table_view.reloadData()
        
        return true
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = storyboard?.instantiateViewController(identifier: "Stock_Display_ViewController") as? Stock_Display_ViewController
        
        if !Filtered && !Filtered_Data.isEmpty
        {
            vc?.name = Struct_Data[indexPath.row].Security_Id
           
        } else if !Filtered_Data.isEmpty
        {
            vc?.name = Filtered_Data[indexPath.row]
            
        }else
        {
           vc?.name = Struct_Data[indexPath.row].Security_Id
            
        }
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !Filtered
        {
            return pages_index
        }
        
        if !Filtered_Data.isEmpty
        {
            if (Filtered_Data.count < 10)
            {
               return Filtered_Data.count
            }else
            {
               return pages_index
            }
       
        }else
        {
         
            return Filtered ? 0 : pages_index
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "checked_cell", for: indexPath) as! Custom_TableViewCell
        
      
        if !Filtered && !Filtered_Data.isEmpty
        {
        
            cell.set(Security_Name: Struct_Data[indexPath.row].Security, Security_id: Struct_Data[indexPath.row].Security_Id)
            
            
        } else if !Filtered_Data.isEmpty
        {
            cell.set(Security_Name: Filtered_Data2[indexPath.row], Security_id: Filtered_Data[indexPath.row])
            
        }
        else
        {
            cell.set(Security_Name: Struct_Data[indexPath.row].Security, Security_id: Struct_Data[indexPath.row].Security_Id)
            
        }
        
        return cell
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position  > (Table_view.contentSize.height  - scrollView.frame.size.height) + 200
        {

            
           if !Filtered
            {
            
            let remaining_count = Struct_Data.count - pages_index
            
                if (remaining_count >= 10)
                {
                    pages_index = pages_index + 10
            
                }
                else
                {
                    pages_index = -(remaining_count)
                    
                }
            Table_view.reloadData()
            }
            
            if !Filtered_Data.isEmpty
            {
                
                let remaining_count = Filtered_Data.count - pages_index
                if (remaining_count >= 10)
                {
                    pages_index = pages_index + 10
                   
                }
                else
                {
                    pages_index = -(remaining_count)
                    
                }
                Table_view.reloadData()
            }
            
            
        }
 
    }
    
    
    
}

