//
//  ContentView.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLogin = userDefaults.object(forKey: TextConstant.IS_LOGIN) as? Bool ?? false
    var body: some View {
        if isLogin{
            NavigationView{
                FoodChoiceList()
            }
        }else{
            NavigationView{
                SignUpView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

