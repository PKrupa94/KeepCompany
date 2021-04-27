//
//  MapView.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//
import MapKit
import Firebase
import SwiftUI

struct MapView: View {
    
    let selectedOption:String
    
    @State var arrRestaurantCoordinates:[MyAnnotationItem] = []
    @State private var showAlert = false
    @State var showSheet = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""
    @State var selectedPlace:String
    @State var rest_id:String

    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.237923, longitude: -118.530197),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            NavigationLink(destination: ChatView(name: self.name, pic: self.pic, uid: self.uid, chat: self.$chat), isActive: self.$chat) {
                Text("")
            }
            Map(coordinateRegion: $region, annotationItems: arrRestaurantCoordinates) { restaurant in
                //MapMarker(coordinate: restaurant.coordinates)
                MapAnnotation(coordinate: restaurant.coordinates,anchorPoint: CGPoint(x: 0.5, y: 0.7)) {
                    VStack{
                        Button(action:{
                            showSheet.toggle()
                        }){
                            Text("\(restaurant.interestedUserCount)").bold().foregroundColor(.black)
                        }
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40, alignment: .bottom)
                            .onTapGesture {
                                selectedPlace = restaurant.restName
                                rest_id = restaurant.rest_id
                                print(rest_id)
                                showAlert.toggle()
                            }
                        Button(action:{
                        }){
                            Text(restaurant.restName).bold().foregroundColor(.black)
                        }
                    }
                }
                
            }
        }.onAppear {
            getCoordinates()
        }.alert(isPresented: self.$showAlert) {
            Alert(title: Text("Confirm"), message: Text("Would you like to visit \(selectedPlace)"), primaryButton:Alert.Button.default(Text("Confirm"), action: {
                let uid = Auth.auth().currentUser?.uid
                
                firestoreInstace.collection(FirebaseCollection.UserInterest).document(selectedOption).collection(selectedPlace).document().setData([TextConstant.USERID:uid!]){ (err) in
                    userDefaults.setValue(selectedOption, forKey: "Category")
                    userDefaults.setValue(selectedPlace, forKey: "place")
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                    }else{
                        firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedOption).collection(selectedOption).document(rest_id).getDocument { snapshot, error in
                            if error != nil{
                                print((err?.localizedDescription)!)
                                return
                            }
                            
                            if let data = snapshot?.data(){
                                print(data)
                                if let count = data[FirebaseCollection.InterestedUserCount] as? Int{
                                    print(count)
                                   let newCount = count + 1
                                    firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedOption).collection(selectedOption).document(rest_id).updateData([FirebaseCollection.InterestedUserCount:newCount])
                                }
                            }
                        }
                    }
                }
                
            }), secondaryButton: .cancel())
        }
        .sheet(isPresented: self.$showSheet) {
            InterestedUsersListView(name: self.$name, uid: self.$uid, pic: self.$pic, show: self.$showSheet, chat: self.$chat,selectedPref:self.$selectedPlace)
        }
    }
    
    func getCoordinates(){
        let docRef = firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedOption)
        docRef.collection(selectedOption).getDocuments() {(snapshot, error) in
            if let error = error{
                print("Error getting Documents: \(error)")
            }else{
                for doc in snapshot!.documents{
                    if let coords = doc.get(FirebaseCollection.Coordinates){
                        let rest_id = doc.documentID
                        let interestedUserCount = doc.get(FirebaseCollection.InterestedUserCount)
                        let restName = doc.get(FirebaseCollection.RestName) as! String
                        let point = coords as! GeoPoint
                        let coodinates = MyAnnotationItem(coordinates: .init(latitude: point.latitude, longitude: point.longitude),rest_id: rest_id,interestedUserCount: interestedUserCount as! Int,restName: restName)
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

