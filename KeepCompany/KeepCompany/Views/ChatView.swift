//
//  ChatView.swift
//  ChatdemoFirebase
//
//  Created by krupa on 3/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct ChatView: View {
    var name : String
    var pic : String
    var uid : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body: some View {
        VStack{
            if msgs.count == 0{
                if self.nomsgs{
                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    Spacer()
                }
                else{
                    Spacer()
                    Spacer()
                }
            }
            else{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8){
                        ForEach(self.msgs){i in
                        HStack{
                            if i.user == userDefaults.value(forKey: TextConstant.USERID) as! String{
                                    Spacer()
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                }
                                else{
                                    
                                    Text(i.msg).padding().background(Color.green).clipShape(ChatBubble(mymsg: false)).foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }
                            
                        }
                    }
                }
            }
            
            HStack{
                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    sendMsg(user: self.name, uid: self.uid, pic: self.pic, date: Date(), msg: self.txt)
                    self.txt = ""
                }) {
                    Text("Send")
                }
            }
            .navigationBarTitle("\(name)",displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.chat.toggle()
            }, label: {
                Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
            }))
            
        }.padding()
        .onAppear {
            self.getMsgs()
        }
    }
    
    func getMsgs(){
        let uid = Auth.auth().currentUser?.uid
        
        firestoreInstace.collection(FirebaseCollection.Messages).document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges{
                if i.type == .added{
                    let id = i.document.documentID
                    let msg = i.document.get(TextConstant.Msg) as! String
                    let user = i.document.get(TextConstant.USERID) as! String
                    self.msgs.append(Msg(id: id, msg: msg, user: user))
                }

            }
        }
    }
}

