//
//  UserCellView.swift
//  ChatdemoFirebase
//
//  Created by krupa on 4/19/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCellView : View {
    var url : String
    var name : String
    var age : String
    var body : some View{
        
        HStack{
            if url != ""{
                AnimatedImage(url: URL(string: url)).resizable().renderingMode(.original).frame(width: 50, height: 50).clipShape(Circle())
            }else{
                Image(systemName: "person.fill")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .foregroundColor(ColorConstant.App_Color)
                    .overlay(Circle().stroke(ColorConstant.App_Color,lineWidth: 4))
                    .padding(.bottom)
            }
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name).foregroundColor(.black).bold()
                        Text(age).foregroundColor(.gray)
                    }
                    Spacer()
                }
                Divider()
            }.padding(5)
        }.padding(5)
    }
}


