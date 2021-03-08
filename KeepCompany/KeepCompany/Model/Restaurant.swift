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
                    print(doc.documentID)
                    arrCuisine.append(doc.documentID)
//                firestoreInstace.collection(FirebaseCollection.CuisineList).document("Mexican").collection("Maxican").getDocuments { (result, error) in
//                    for r in result!.documents{
//                        print(r.documentID)
//                        print(r.data())
//                    }
//                    print(result)
//                    print(error)
//                }
              
                }
            }
        }
    }
}

struct Restaurant: Hashable,Codable{
    var name:String
 
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
}

