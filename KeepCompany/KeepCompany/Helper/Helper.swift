//
//  Helper.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import Foundation
import SwiftUI

class Helper:NSObject{
    class func showAlert(_ title:String,_ text:String){
        Alert(title: Text(title), message:Text(text))
    }
}
