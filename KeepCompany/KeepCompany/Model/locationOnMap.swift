//
//  locationOnMap.swift
//  KeepCompany
//
//  Created by Jitendrakumar Sodvadiya on 3/8/21.
//

import Firebase
import FirebaseFirestore
import Foundation
import CoreLocation
import SwiftUI


struct MyAnnotationItem:Identifiable{
    let id = UUID()
    var coordinates:CLLocationCoordinate2D
}

class locationOnMap: ObservableObject {
       
     //fetch all documents data
    var arrRestaurantCoordinates:[MyAnnotationItem] = []
    
     func getCoodinatesData() -> [MyAnnotationItem] {
        if let getRest = userDefaults.object(forKey: TextConstant.SELECTDEDRES) as? String{
            let docRef = firestoreInstace.collection(FirebaseCollection.CuisineList).document(getRest)
                    docRef.collection(getRest).getDocuments() {(snapshot, error) in
                        if let error = error{
                            print("Error getting Documents: \(error)")
                        }else{
                            for doc in snapshot!.documents{
                                if let coords = doc.get("coordinates"){
                                    let point = coords as! GeoPoint
                                    let coodinates = MyAnnotationItem(coordinates: .init(latitude: point.latitude, longitude: point.longitude))
                                    self.arrRestaurantCoordinates.append(coodinates)
                                }
                            }
                            print(self.arrRestaurantCoordinates)
                        }
                }
        }
        return arrRestaurantCoordinates
    }
}
    
    


