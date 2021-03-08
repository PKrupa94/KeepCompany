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
        Auth.auth().signIn(withEmail: email, password: password) { (userResult, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code){
                completionBlock(false)
            }else{
//                print(userResult)
                if let user = userResult?.user{
                    userDefaults.set(user.uid, forKey: TextConstant.USERID)
                    userDefaults.set(user.displayName,forKey: TextConstant.USERNAME)
                    userDefaults.set(user.email,forKey: TextConstant.EMAIL)
                }
                completionBlock(true)
                
            }
        }
        
    }
    
}
