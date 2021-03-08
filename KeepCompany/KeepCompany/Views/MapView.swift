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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.67, longitude: 139.65),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
   
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

