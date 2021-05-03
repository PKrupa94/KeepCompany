//
//  MapView.swift
//  KeepCompany
//
//  Created by krupa on 3/3/21.
//
import MapKit
import Firebase
import SwiftUI

struct UserPreRest {
    static var selectedCategory:String = ""
    static var selectedRest:String = ""
}

struct MapView: View {
    
    let selectedCategory:String

    @State var arrRestaurantCoordinates:[MyAnnotationItem] = []
    @State var showAlert = false
    @State var showSheet = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""

    @State var rest_id:String

    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.237923, longitude: -118.530197),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var body: some View {
        VStack {
            NavigationLink(destination: ChatView(name: self.name, pic: self.pic, uid: self.uid, chat: self.$chat), isActive: self.$chat) {
                Text("")
            }
            Map(coordinateRegion: $region, annotationItems: arrRestaurantCoordinates) { restaurant in
                MapAnnotation(coordinate: restaurant.coordinates,anchorPoint: CGPoint(x: 0.5, y: 0.7)) {
                    VStack{
                        Button(action:{
                            UserPreRest.selectedCategory = selectedCategory
                            UserPreRest.selectedRest = restaurant.restName
                            showSheet.toggle()
                        }){
                            Text("\(restaurant.interestedUserCount)").bold().foregroundColor(.red)
                        }
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40, alignment: .bottom)
                            .onTapGesture {
                                UserPreRest.selectedRest = restaurant.restName
                                rest_id = restaurant.rest_id
                                print(rest_id)
                                showAlert.toggle()
                            }
                        Button(action:{
                        }){
                            Text(restaurant.restName).bold().foregroundColor(.red)
                        }
                    }
                }
                
            }
        }.onAppear {
            getCoordinates()
        }.alert(isPresented: self.$showAlert) {
            Alert(title: Text("Confirm"), message: Text("Would you like to visit \(UserPreRest.selectedRest)"), primaryButton:Alert.Button.default(Text("Confirm"), action: {
                let uid = Auth.auth().currentUser?.uid
                //setData to userinterest
                firestoreInstace.collection(FirebaseCollection.UserInterest).document(selectedCategory).collection(UserPreRest.selectedRest).document().setData([TextConstant.USERID:uid!]){ (err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                    }else{
                        //fetch userinterest count from rest database
                        firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedCategory).collection(selectedCategory).document(rest_id).getDocument { snapshot, error in
                            if error != nil{
                                print((err?.localizedDescription)!)
                                return
                            }
                            
                            if let data = snapshot?.data(){
                                print(data)
                                if let count = data[FirebaseCollection.InterestedUserCount] as? Int{
                                    print(count)
                                   let newCount = count + 1
                                    //Update userinterest count
                                    firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedCategory).collection(selectedCategory).document(rest_id).updateData([FirebaseCollection.InterestedUserCount:newCount])
                                }
                            }
                        }
                    }
                }
                
            }), secondaryButton: .cancel())
        }
        .sheet(isPresented: self.$showSheet) {
            InterestedUsersListView(name: self.$name, uid: self.$uid, pic: self.$pic, show: self.$showSheet, chat: self.$chat)
        }
    }
    
    func getCoordinates(){
        let docRef = firestoreInstace.collection(FirebaseCollection.CuisineList).document(selectedCategory)
        docRef.collection(selectedCategory).getDocuments() {(snapshot, error) in
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

