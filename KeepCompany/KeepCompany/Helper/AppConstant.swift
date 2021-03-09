//
//  AppConstant.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore


let firestoreInstace = Firestore.firestore()
let userDefaults = UserDefaults.standard

struct FirebaseCollection{
    static let CuisineList = "CuisineList"
    static let userIntrest = "UserIntrest"
    
}

struct ColorConstant{
    static let ROSE = Color("FieryRose")
    static let YELLOW = Color("yellow")
    static let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
}

struct TextConstant {
    static let EMAIL = "Email"
    static let PASSWORD = "Password"
    static let LOGIN = "LOGIN"
    static let SIGNUP = "SIGN UP"
    static let USERNAME = "username"
    static let USERID = "userID"
}

struct AlertMessage {
    static let CONFIRM = "would you like to visit any restaurant from this cuisine?"
    static let BTNCONFIRM = "Confirm"
    static let ERROR = "Error"
    static let LOGIN_ERROR = "Please check your email and password"
}

struct NavigationTitle {
    static let CATEGORIES = "Categories"
    static let Register = "Register Now"
}


