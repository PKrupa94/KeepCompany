//
//  UserListModel.swift
//  ChatdemoFirebase
//
//  Created by krupa on 4/19/21.
//

import Foundation
import Firebase
import FirebaseFirestore

struct User : Identifiable {
    var id : String
    var name : String
    var pic : String
    var age : String
}


class getAllUsers : ObservableObject{
    
    @Published var users = [User]()
    @Published var empty = false
    
    init() {
//        let selectedPlace = userDefaults.object(forKey: "place") as! String
//        let Category = userDefaults.object(forKey: "Category") as! String

        let docRef = firestoreInstace.collection(FirebaseCollection.UserInterest).document(UserPreRest.selectedCategory)
        docRef.collection(UserPreRest.selectedRest).getDocuments { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            if (snap?.documents.isEmpty)!{
                self.empty = true
                return
            }
            for i in snap!.documents{
                let user_id = i.get(TextConstant.USERID) as! String
                firestoreInstace.collection(FirebaseCollection.Users).document(user_id).getDocument { (snap, error) in
                    if let userData = snap?.data(){
                        print(userData)
                        guard let name = userData[TextConstant.USERNAME] as? String else {return}
                        guard let pic = userData[TextConstant.ProfilePic] as? String else {return}
                        guard let age = userData[TextConstant.AGE] as? String else {return}
                        if user_id != userDefaults.value(forKey: TextConstant.USERID) as! String{
                            self.users.append(User(id: user_id, name: name, pic: pic, age: age))
                        }
                    }
                }
            }
            
            if self.users.isEmpty{
                self.empty = true
            }
        }
        //        db.collection("Intrest").getDocuments { (snap, err) in
        //            if err != nil{
        //                print((err?.localizedDescription)!)
        //                self.empty = true
        //                return
        //            }
        //            if (snap?.documents.isEmpty)!{
        //                self.empty = true
        //                return
        //            }
        //            for i in snap!.documents{
        //                let id = i.documentID
        //                let name = i.get("name") as! String
        //                let pic = i.get("pic") as! String
        //                let age = i.get("Age") as! String
        //
        //                if id != UserDefaults.standard.value(forKey: "UID") as! String{
        //                    self.users.append(User(id: id, name: name, pic: pic, age: age))
        //                }
        //            }
        //
        //            if self.users.isEmpty{
        //                self.empty = true
        //            }
        //        }
    }
}
