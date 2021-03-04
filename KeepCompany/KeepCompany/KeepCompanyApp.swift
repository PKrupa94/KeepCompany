//
//  KeepCompanyApp.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import SwiftUI
import Firebase

@main
struct KeepCompanyApp: App {
    
    init() {
        firebaseSetup()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension KeepCompanyApp{
    func firebaseSetup(){
        FirebaseApp.configure()
    }
}
