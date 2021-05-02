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
    @State private var isUserConfirm: Bool = false
    @State var arrCuisine:[String] = []
    
    var body: some View {
        List(arrCuisine,id:\.self){ name in
            NavigationLink(destination: MapView(selectedCategory:name, rest_id: "")){
                Text(name).font(.subheadline).foregroundColor(.black)
            }
            .navigationTitle(NavigationTitle.CATEGORIES).navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear(){
            getCuisineData()
        }.onDisappear(){
            arrCuisine.removeAll()
        }
    }
    
    func getCuisineData(){
        firestoreInstace.collection(FirebaseCollection.CuisineList).getDocuments() { [self] (snapshot, error) in
            if let err = error{
                print(err)
            }else{
                for doc in snapshot!.documents{
                    arrCuisine.append(doc.documentID)
                }
            }
        }
    }
}

struct FoodChoiceList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        FoodChoiceList()
        }
    }
}

