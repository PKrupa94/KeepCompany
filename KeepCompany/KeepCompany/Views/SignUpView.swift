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
    @State var name = ""
    @State var imagedata : Data = .init(count: 0)
    @State var selectedGender = 0
    @State private var birthDate = Date()
    @State private var showAlert = false
    @State private var isLoginClicked: Bool = false
    @State private var isSignUpSuccess: Bool = false
    @State private var isFalseInfo: Bool = false
    @State private var showingImagePicker = false
    let genders = ["Male", "Female"]

    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1970, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(ColorConstant.App_Color)
        //and this changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = .white

        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
    }
    
    
    var body: some View{
        
        ZStack(alignment: .bottom) {
            VStack{
                HStack{
                    //ImagePicker
                    Button(action: {
                        self.showingImagePicker.toggle()
                    }) {
                        if self.imagedata.count == 0{
                            Image(systemName: "person.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .foregroundColor(ColorConstant.App_Color)
                                .overlay(Circle().stroke(ColorConstant.App_Color,lineWidth: 4))
                                .padding(.bottom)
                        }
                        else{
                            Image(uiImage: UIImage(data: self.imagedata)!).resizable().renderingMode(.original)
                                .clipShape(Circle())
                                .frame(width:150, height:150)
                                .foregroundColor(Color.gray)
                                .overlay(Circle().stroke(Color.gray, lineWidth:4))
                                .padding(.bottom)
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
                    "BIRTHDATE",
                    selection: $birthDate,
                    in: dateRange,
                    displayedComponents: [.date]
                ).foregroundColor(.pink)
                .font(.system(size: 15, weight: .bold , design: .default))
                .padding(.horizontal)
                .padding(.bottom, 30)
                .accentColor(.pink)
                
                //GENDER
                VStack{
                    HStack(spacing: 15) {
                        Image(systemName: "person.fill.questionmark")
                            .foregroundColor(ColorConstant.App_Color)
                        Picker("", selection: $selectedGender) {
                            ForEach(0..<genders.count) { index in
                                Text(self.genders[index]).tag(index).font(.title)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                    }.padding(.horizontal)
                    .padding(.bottom, 30)
                    .accentColor(.pink)
                }
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
               
                    .alert(isPresented: self.$showAlert) {
                        Alert(title:Text(AlertMessage.ERROR), message: Text("Error while creating user.Please try again"), dismissButton: .cancel())
                    }
                    .alert(isPresented: self.$isFalseInfo) {
                        Alert(title:Text(AlertMessage.ERROR), message: Text("You need to fill up all the details along with your profile picture"), dismissButton: .cancel())
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
                }
                
            }.sheet(isPresented: self.$showingImagePicker, content: {
                ImagePicker(picker: self.$showingImagePicker, imagedata: self.$imagedata)
            })
            
        }
        
    func SignUp(){
        //convert selected birthdate to age
        let ageComponents = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
        let age = String(ageComponents.year!)
        if (Helper.textFieldValidatorEmail(self.email) && self.password != "" && self.name != "" && age != "") {
            FirebaseAuthManager().userSignUp(email: self.email, password: self.password, username: self.name, age:age, gender: self.genders[selectedGender],userImageData: self.imagedata) { (success) in
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


