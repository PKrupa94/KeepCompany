//
//  ContentView.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    //FoodChoiceList()
      // Home()
        SignUpViewPage()
     //  LoginView()
//        Text("Hello, world!")
//            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//import SwiftUI
//import MapKit
//import Firebase
//
//struct Place: Identifiable {
//    let id = UUID()
//    let name: String
//    let latitude: Double
//    let longitude: Double
//    var coordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//}
//
//struct ContentView: View {

// @ObservedObject var arrCoodinates = locationOnMap() // create an instance
////
////    @State private var region = MKCoordinateRegion(
////        center: CLLocationCoordinate2D(latitude: 35.67, longitude: 139.65),
////        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
////
////    var body: some View {
////
////       // Map(coordinateRegion: $region)
////
////    }
//
//    let places = [
//            Place(name: "British Museum", latitude: 51.519581, longitude: -0.127002),
//            Place(name: "Tower of London", latitude: 51.508052, longitude: -0.076035),
//            Place(name: "Big Ben", latitude: 51.500710, longitude: -0.124617)
//        ]
//
//        @State var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 51.514134, longitude: -0.104236),
//            span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
//
//
//        var body: some View {
//            Map(coordinateRegion: $region, annotationItems: places) { place in
//                // Insert an annotation type here
//                MapMarker(coordinate: place.coordinate)
//            }
//            .ignoresSafeArea(.all)
//        }
//
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
