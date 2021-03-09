//
//  SignUpView.swift
//  KeepCompany
//
//  Created by krupa on 3/9/21.
//

import SwiftUI

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


    var body: some View{
        
        ZStack(alignment: .bottom) {
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    VStack(spacing: 50){
                    }
                }
                .padding(.top, 100)// for top curve...
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
                VStack{
                    HStack(spacing: 15){
                        Image(systemName:ImageConstant.img_age)
                            .foregroundColor(ColorConstant.App_Color)
                        TextField(TextConstant.AGE, text: self.$age).keyboardType(.numberPad)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
                //GENDER
                VStack{
                    HStack(spacing: 15){
                        Image(systemName:ImageConstant.img_gender )
                            .foregroundColor(ColorConstant.App_Color)
                        TextField(TextConstant.GENDER, text: self.$gender)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                NavigationLink(destination:FoodChoiceList(), isActive: $isSignUpSuccess,label: { EmptyView() })
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
            }
            //zstack end
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



