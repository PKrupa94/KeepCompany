//
//  AppConstant.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore

let ROSE = Color("FieryRose")
let YELLOW = Color("yellow")
let firestoreInstace = Firestore.firestore()


struct AlertMessage {
    static let CONFIRM = "would you like to visit any restaurant from this cuisine?"
    static let BTNCONFIRM = "Confirm"
}

struct NavigationTitle {
    static let CATEGORIES = "Categories"
}

enum CuisineType:String {
    case Indian
    case Italian
    case Maxican
    case American 
}
