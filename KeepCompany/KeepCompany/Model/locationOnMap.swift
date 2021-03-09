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


struct MyAnnotationItem{
    var coordinates:CLLocationCoordinate2D
}


class locationOnMap: ObservableObject {
       
     //fetch all documents data
        private let db = Firestore.firestore()
        @Published var arrLoc:[MyAnnotationItem] = []
       
            init(){
                let docRef = db.collection("CuisineList").document("American")
                docRef.collection("American").getDocuments() {(snapshot, error) in
                    if let error = error{
                        print("Error getting Documents: \(error)")
                    }else{
                        for doc in snapshot!.documents{
                            if let coords = doc.get("coordinates"){
                                let point = coords as! GeoPoint
                                let coodinates = MyAnnotationItem(coordinates: CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude))
                                print(point.latitude)
                                print(point.longitude)
                                self.arrLoc.append(coodinates)
                            }
                        }
                    }
                }
            }

}
    
    


