//
//  Restaurant.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import Foundation
import Firebase
import CoreLocation
import SwiftUI

class CuisineModel: ObservableObject{
    @Published  var arrCuisine:[String] = []
    
    init() {
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

