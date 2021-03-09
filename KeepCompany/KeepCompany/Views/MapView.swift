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
    
    @ObservedObject var arrCoodinates = locationOnMap()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.237923, longitude: -118.530197),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: arrCoodinates.arrRestaurantCoordinates) { restaurant in
            MapMarker(coordinate: restaurant.coordinates)}
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


