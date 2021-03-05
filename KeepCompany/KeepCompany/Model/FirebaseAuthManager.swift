//
//  FirebaseAuthManager.swift
//  KeepCompany
//
//  Created by krupa on 3/4/21.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager{
    
    func signIn(email:String,password:String,completionBlock: @escaping(_ success:Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code){
                completionBlock(false)
            }else{
                print(result)
                completionBlock(true)
            }
        }
        
    }
    
}
