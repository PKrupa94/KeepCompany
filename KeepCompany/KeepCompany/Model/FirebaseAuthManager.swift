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
                if let user = userResult?.user{
                    userDefaults.set(user.uid, forKey: TextConstant.USERID)
                    userDefaults.set(user.displayName,forKey: TextConstant.USERNAME)
                    userDefaults.set(user.email,forKey: TextConstant.EMAIL)
                    userDefaults.set(true,forKey: TextConstant.IS_LOGIN)
                }
                completionBlock(true)
                
            }
        }
    }
    
    func userSignUp(email:String,password:String,username:String,age:String,gender:String,completionBlock: @escaping(_ success:Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error == nil){
                let userId = Auth.auth().currentUser?.uid
                firestoreInstace.collection(FirebaseCollection.Users).document(userId!).setData(
                    [TextConstant.EMAIL:email,TextConstant.AGE:age,TextConstant.GENDER:gender,TextConstant.USERNAME:username]){ error in
                    if let error = error{
                        print("Error adding document: \(error)")
                        completionBlock(false)
                    }else{
                        userDefaults.set(userId, forKey: TextConstant.USERID)
                        userDefaults.set(username,forKey: TextConstant.USERNAME)
                        userDefaults.set(email,forKey: TextConstant.EMAIL)
                        userDefaults.set(age,forKey: TextConstant.AGE)
                        userDefaults.set(true,forKey: TextConstant.IS_LOGIN)
                        completionBlock(true)
                    }
                }
            }
        }
        
    }
    
}
