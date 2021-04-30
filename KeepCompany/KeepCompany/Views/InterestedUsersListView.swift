//
//  InterestedUsersListView.swift
//  ChatdemoFirebase
//
//  Created by krupa on 4/19/21.
//

import SwiftUI

struct InterestedUsersListView: View {
    @Binding var name : String
    @Binding var uid : String
    @Binding var pic : String
    @Binding var show : Bool
    @Binding var chat : Bool
//    @Binding var selectedPref:String
    @ObservedObject var datas = getAllUsers()
   
    
    var body : some View{
        VStack(alignment: .leading){
                if self.datas.users.count == 0{
                    if self.datas.empty{
                        Text("No Users Found")
                    }
                }
                else{
                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12){
                            ForEach(datas.users){i in
                                Button(action: {
                                    self.uid = i.id
                                    self.name = i.name
                                    self.pic = i.pic
                                    self.show.toggle()
                                    self.chat.toggle()
                                }) {
                                    UserCellView(url: i.pic, name: i.name, age: i.age)
                                }
                            }
                            
                        }
                    }
              }
        }.padding()
    }
}


