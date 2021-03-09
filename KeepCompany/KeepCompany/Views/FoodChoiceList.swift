//
//  FoodChoiceList.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import SwiftUI

struct FoodChoiceList: View {
    
    @State private var showingAlert = false
    @State var selection: Int? = nil
    @State private var clickedItem = ""
    @ObservedObject var cuisineModel = CuisineModel()

    var body: some View {
       // NavigationView{
            NavigationLink(destination: MapView(), tag: 1, selection: self.$selection){}
            List(cuisineModel.arrCuisine,id:\.self){ name in
                Text(name).font(.subheadline).foregroundColor(.black)
                Button(action: {
                    self.clickedItem = name
                    userDefaults.setValue(self.clickedItem, forKey: TextConstant.SELECTDEDRES)
                    self.showingAlert = true
                }) {Text("")}
            }.alert(isPresented:self.$showingAlert, content: {
                Alert(title:Text("Confirm Dialog"), message: Text(AlertMessage.CONFIRM), primaryButton: Alert.Button.default(Text(AlertMessage.BTNCONFIRM)){
                    if let userId = userDefaults.object(forKey: TextConstant.USERID) as? String{
                        var name:String = "Test"
                        if let userName = userDefaults.object(forKey: TextConstant.USERNAME) as? String{
                            name = userName
                        }
                        firestoreInstace.collection(FirebaseCollection.userIntrest).document(userId).setData(["name":name]) { (error) in
                            if let err = error{
                                print(err)
                            }else{
                                self.selection = 1
                            }
                        }
                    }
                }, secondaryButton: .cancel())
           })
            .navigationTitle(NavigationTitle.CATEGORIES).navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
          // }
        }
}

struct FoodChoiceList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodChoiceList()
            FoodChoiceList()
            FoodChoiceList()
        }
    }
}

