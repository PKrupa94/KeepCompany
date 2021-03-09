//
//  MapView.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//
import MapKit
import Firebase
import SwiftUI
/*
struct MapView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
*/

struct MapView: View {
    
    //@ObservedObject var arrCoodinates = locationOnMap()
   @State var arrRestaurantCoordinates:[MyAnnotationItem] = []
   let selectedOption:String
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.237923, longitude: -118.530197),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: arrRestaurantCoordinates) { restaurant in
                        MapMarker(coordinate: restaurant.coordinates)}
        }.onAppear {
            getCoordinates()
        }
    
    }
    
    func getCoordinates(){
      //  if let getRest = userDefaults.object(forKey: TextConstant.SELECTDEDRES) as? String{
            let docRef = firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedOption)
                    docRef.collection(selectedOption).getDocuments() {(snapshot, error) in
                        if let error = error{
                            print("Error getting Documents: \(error)")
                        }else{
                            for doc in snapshot!.documents{
                                if let coords = doc.get(FirebaseCollection.Coordinates){
                                    let point = coords as! GeoPoint
                                    let coodinates = MyAnnotationItem(coordinates: .init(latitude: point.latitude, longitude: point.longitude))
                                    self.arrRestaurantCoordinates.append(coodinates)
                                }
                            }
                            print(self.arrRestaurantCoordinates)
                        }
                    }
        }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

