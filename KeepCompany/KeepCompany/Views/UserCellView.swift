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
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name).foregroundColor(.black)
                        Text(age).foregroundColor(.gray)
                    }
                    Spacer()
                }
                Divider()
            }
        }
    }
}


