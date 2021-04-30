//
//  FirebaseAuthManager.swift
//  KeepCompany
//
//  Created by krupa on 3/4/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage



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
    
    func userSignUp(email:String,password:String,username:String,age:String,gender:String,userImageData:Data,completionBlock: @escaping(_ success:Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error == nil){
                let userId = Auth.auth().currentUser?.uid
                let storage = Storage.storage().reference()
                //Put imagedata on firebase
                storage.child(FirebaseCollection.UsersProfilePic).child(userId!).putData(userImageData, metadata: nil){(_,error) in
                    if error != nil{
                        print((error?.localizedDescription)!)
                    }else{
                        //fetch user profile url from FB
                        storage.child(FirebaseCollection.UsersProfilePic).child(userId!).downloadURL { (url, err) in
                            if err != nil{
                                print((err?.localizedDescription)!)
                            }
                            
                            var strImageUrl = ""
                            if let getUrl =  url{
                                strImageUrl = "\(getUrl)"
                            }
                            
                            //Store userdata to FB
                            firestoreInstace.collection(FirebaseCollection.Users).document(userId!).setData(
                                [TextConstant.EMAIL:email,TextConstant.AGE:age,TextConstant.GENDER:gender,TextConstant.USERNAME:username,TextConstant.ProfilePic:strImageUrl]){ error in
                                if let error = error{
                                    print("Error adding document: \(error)")
                                    completionBlock(false)
                                }else{
                                    userDefaults.set(userId, forKey: TextConstant.USERID)
                                    userDefaults.set(username,forKey: TextConstant.USERNAME)
                                    userDefaults.set(email,forKey: TextConstant.EMAIL)
                                    userDefaults.set(age,forKey: TextConstant.AGE)
                                    userDefaults.set(strImageUrl,forKey: TextConstant.ProfilePic)
                                    userDefaults.set(true,forKey: TextConstant.IS_LOGIN)
                                    completionBlock(true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
