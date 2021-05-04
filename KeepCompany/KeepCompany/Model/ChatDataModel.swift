//
//  ChatDataModel.swift
//  ChatdemoFirebase
//
//  Created by krupa on 4/19/21.
//

import Foundation
import Firebase
import FirebaseFirestore



func sendMsg(user: String,uid: String,pic: String,date: Date,msg: String){
    let myuid = Auth.auth().currentUser?.uid
    firestoreInstace.collection(FirebaseCollection.Users).document(uid).collection(FirebaseCollection.RecentMsg).document(myuid!).getDocument { (snap, err) in
        if err != nil{
            print((err?.localizedDescription)!)
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            return
        }
        if !snap!.exists{
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
        }
        else{
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
    }
    updateDB(uid: uid, msg: msg, date: date)
}

func setRecents(user: String,uid: String,pic: String,msg: String,date: Date){
    
    
    let myuid = Auth.auth().currentUser?.uid
    
    var senderName = ""
    if let myname = userDefaults.value(forKey: TextConstant.USERNAME) as? String{
        senderName = myname
    }
    
    var senderPic = ""
    if let mypic = userDefaults.value(forKey: TextConstant.ProfilePic) as? String{
        senderPic = mypic
    }
    
    firestoreInstace.collection(FirebaseCollection.Users).document(uid).collection(FirebaseCollection.RecentMsg).document(myuid!).setData([TextConstant.USERNAME:senderName,TextConstant.ProfilePic:senderPic,TextConstant.LASTMSG:msg,TextConstant.MSGDATE:date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    firestoreInstace.collection(FirebaseCollection.Users).document(myuid!).collection(FirebaseCollection.RecentMsg).document(uid).setData([TextConstant.USERNAME:user,TextConstant.ProfilePic:pic,TextConstant.LASTMSG:msg,TextConstant.MSGDATE:date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(uid: String,lastmsg: String,date: Date){
    let myuid = Auth.auth().currentUser?.uid
    
    firestoreInstace.collection(FirebaseCollection.Users).document(uid).collection(FirebaseCollection.RecentMsg).document(myuid!).updateData([TextConstant.LASTMSG:lastmsg,TextConstant.MSGDATE:date])
    
    firestoreInstace.collection(FirebaseCollection.Users).document(myuid!).collection(FirebaseCollection.RecentMsg).document(uid).updateData([TextConstant.LASTMSG:lastmsg,TextConstant.MSGDATE:date])
}

func updateDB(uid: String,msg: String,date: Date){
    let myuid = Auth.auth().currentUser?.uid
    firestoreInstace.collection(FirebaseCollection.Messages).document(uid).collection(myuid!).document().setData([TextConstant.Msg:msg,TextConstant.USERID:myuid!,TextConstant.MSGDATE:date]) { (err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
    
    firestoreInstace.collection(FirebaseCollection.Messages).document(myuid!).collection(uid).document().setData([TextConstant.Msg:msg,TextConstant.USERID:myuid!,TextConstant.MSGDATE:date]) { (err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
}
