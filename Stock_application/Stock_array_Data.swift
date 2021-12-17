//
//  Stock_array_Data.swift
//  Stock_application
//
//  Created by Gokul Gopalakrishnan on 10/10/21.
//

import Foundation

import UIKit

struct Stocks_Array_data: Codable {

      var Security_Code : Int
      var Issuer_Name : String
      var Security_Id : String
      var Security : String
      var Status : String?
      var Group : String
      var Face_Value : Int
      var ISIN_No: String
      var Industry : String
      var Instrument : String
}
