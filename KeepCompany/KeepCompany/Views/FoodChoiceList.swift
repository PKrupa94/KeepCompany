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

    //    init() {
    //        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    //    }
    var body: some View {
        NavigationView{
            List(cuisineModel.arrCuisine,id:\.self){ name in
                Text(name).font(.subheadline).foregroundColor(.black)
                NavigationLink(destination: MapView(), tag: 1, selection: self.$selection){}
                Button(action: {
                    self.clickedItem = name
                    self.showingAlert = true
                }) {Text("")}
            }.alert(isPresented:self.$showingAlert, content: {
                Alert(title:Text("Confirm Dialog"), message: Text(AlertMessage.CONFIRM), primaryButton: Alert.Button.default(Text(AlertMessage.BTNCONFIRM)){
                    let userId = userDefaults.object(forKey: TextConstant.USERID) as? String
                    //TODO:setup data
                    firestoreInstace.collection(FirebaseCollection.userIntrest).document(userId!).setData(["name":"Krupa"]) { (error) in
                        if let err = error{
                            print(err)
                        }else{
                            self.selection = 1
                        }
                    }
                }, secondaryButton: .cancel())
           })
            .navigationTitle(NavigationTitle.CATEGORIES).navigationBarTitleDisplayMode(.inline)
            }
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

