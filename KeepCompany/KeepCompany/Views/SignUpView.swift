import SwiftUI
import Firebase

struct SignUpView: View {
    @State var index = 0
    var body: some View {
        SignUP()
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


struct SignUP : View {
    
    @State var email = ""
    @State var password = ""
    @State var age = ""
    @State var name = ""
    @State var gender = ""
    @State private var showAlert = false
    @State private var isLoginClicked: Bool = false
    @State private var isSignUpSuccess: Bool = false
    @State private var isFalseInfo: Bool = false
    @State var picker = false
    @State var loading = false
    @State var imagedata : Data = .init(count: 0)
    @State var alert = false
    @State private var showingImagePicker = false
    @State var image: Image? = nil
    @State var upload_image:UIImage?
    @State var shown = false
    @State var selectedGender = 0
    @State private var date = Date()
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    let genders = ["Male", "Female"]
    
    var body: some View{
        
        
        
        
        
        ZStack(alignment: .bottom) {
            VStack{
                
                HStack{
                    
                    
                    //ImagePicker
                    VStack {
                        
                        
                        if image == nil {
                            
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color.pink)
                                .overlay(Circle().stroke(Color.pink,lineWidth: 4))
                                .padding(.bottom)
                        } else{
                            image?.resizable()
                                .clipShape(Circle())
                                .frame(width:150, height:150)
                                .foregroundColor(Color.gray)
                                .overlay(Circle().stroke(Color.gray, lineWidth:4))
                                .padding(.bottom)
                        }
                        
                        //Button
                        
                        /*         Button(action: {
                         
                         self.picker.toggle()
                         
                         })
                         {
                         
                         
                         if self.imagedata.count == 0{
                         
                         
                         Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width:150, height:150 ).foregroundColor(.pink)
                         
                         
                         }
                         else{
                         
                         Image(uiImage: UIImage(data: self.imagedata)!).resizable()
                         .renderingMode(.original)
                         .frame(width: 150, height: 150).clipShape(Circle())
                         }
                         
                         }
                         */
                        
                        Button("Choose Profile Picture")
                        {
                            self.showingImagePicker.toggle()
                        }.foregroundColor(.black)
                        .sheet(isPresented: $showingImagePicker,
                               content: {
                                ImagePicker.shared.view
                               }).onReceive(ImagePicker.shared.$image) {image in self.image = image
                                
                               }
                        
                    }
                }
                .padding(.top, 15)// for top curve...
                
                //NAME
                VStack{
                    HStack(spacing: 15){
                        Image(systemName:ImageConstant.img_person)
                            .foregroundColor(ColorConstant.App_Color)
                        TextField(TextConstant.USERNAME, text: self.$name)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
                //EMAIL
                VStack{
                    HStack(spacing: 15){
                        Image(systemName:ImageConstant.img_email)
                            .foregroundColor(ColorConstant.App_Color)
                        TextField(TextConstant.EMAIL, text: self.$email)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
                //PASSWORD
                VStack{
                    HStack(spacing: 15){
                        Image(systemName:ImageConstant.img_password)
                            .foregroundColor(ColorConstant.App_Color)
                        SecureField(TextConstant.PASSWORD, text: self.$password)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
                //AGE
                DatePicker(
                    "DOB",
                    selection: $date,
                    in: dateRange,
                    displayedComponents: [.date]
                ).foregroundColor(.pink)
                .font(.system(size: 15, weight: .heavy, design: .default))
                .padding(.horizontal)
                .padding(.bottom, 30)
                .accentColor(.pink)
                
                /*     VStack{
                 HStack(spacing: 15){
                 Image(systemName:ImageConstant.img_age)
                 .foregroundColor(ColorConstant.App_Color)
                 TextField(TextConstant.AGE, text: self.$age).keyboardType(.numberPad)
                 }
                 Divider().background(Color.white.opacity(0.5))
                 }
                 .padding(.horizontal)
                 .padding(.bottom, 30)
                 */
                
                
                //GENDER
                VStack{
                    
                    HStack(spacing: 15) {
                        Image(systemName: "person.fill.questionmark")
                            .foregroundColor(Color.pink)
                        Picker("", selection: $selectedGender) {
                            
                            ForEach(0..<genders.count) { index in
                                Text(self.genders[index]).tag(index).font(.title)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                    }.padding(.horizontal)
                    .padding(.bottom, 30)
                    .accentColor(.pink)
                    
                    
                    
                    
                    
                    Button(action: {
                        SignUp()
                    }) {
                        Text(TextConstant.SIGNUP)
                            .multilineTextAlignment(.center)
                            .frame(height: 27.0)
                            .frame(width: 200 , height: 50, alignment: .center)
                    }
                    .background(ColorConstant.App_Color)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    // }
                    
                    .alert(isPresented: self.$showAlert) {
                        Alert(title:Text(AlertMessage.ERROR), message: Text("Please Upload Profile Picture, If uploaded then plaese Continue"), dismissButton: .cancel())
                    }
                    
                    .alert(isPresented: self.$showAlert) {
                        Alert(title:Text(AlertMessage.ERROR), message: Text("Error while creating user.Please try again"), dismissButton: .cancel())
                    }
                    .alert(isPresented: self.$isFalseInfo) {
                        Alert(title:Text(AlertMessage.ERROR), message: Text("Please Enter valid details"), dismissButton: .cancel())
                    }
                    //// Button2
                    NavigationLink(destination:LoginView(), isActive: $isLoginClicked,label: { EmptyView() })
                    
                    
                    
                    Button(action: {
                        self.isLoginClicked = true
                    }) {
                        Text("Already have an account? SIGN IN!")
                            .multilineTextAlignment(.center)
                            .frame(height: 27.0)
                            .frame(width: 350 , height: 50, alignment: .center)
                    }
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    //zstack end
                }
                
            }
            
            
        }
        
    }
    
    func SignUp(){
        if (Helper.textFieldValidatorEmail(self.email) && self.password != "") {
            FirebaseAuthManager().userSignUp(email: self.email, password: self.password, username: self.name, age: self.age, gender: self.gender) { (success) in
                if success{
                    self.isSignUpSuccess = true
                }else{
                    self.showAlert = true
                }
            }
        }else{
            self.isFalseInfo = true
        }
    }
}


