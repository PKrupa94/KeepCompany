//
//  LoginView.swift
//  KeepCompany
//
//  Created by krupa on 3/4/21.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var isEmailValid:Bool = true
    @State private var showAlert = false
//    @State var selection: Int? = nil
    @State private var isLoginSuccess: Bool = false


    
    var body: some View {
//        NavigationView{
        ZStack(alignment: .bottom) {
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    VStack(spacing: 50){
                    }
                }
                .padding(.top, 100)// for top curve...
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
                //Paasword
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
               // Button1
               // NavigationLink(destination: FoodChoiceList(), tag: 1, selection: self.$selection){
                NavigationLink(destination:FoodChoiceList(), isActive: $isLoginSuccess,
                                 label: { EmptyView() })
                    Button(action: {
                        logIn()
                    }, label: {
                        Text(TextConstant.LOGIN)
                            .multilineTextAlignment(.center)
                            .frame(height: 27.0)
                            .frame(width: 200 , height: 50, alignment: .center)
                            .background(ColorConstant.App_Color)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
               // }
                .alert(isPresented: self.$showAlert) {
                    Alert(title:Text(AlertMessage.ERROR), message: Text(AlertMessage.LOGIN_ERROR), dismissButton: .cancel())
                }
            }
            .navigationTitle("").navigationBarHidden(false)
            .padding(.horizontal)
            .padding(.bottom, 45)
          //  .background(Color("Color").edgesIgnoringSafeArea(.all))
        }
  
    //}
//        NavigationView{
//            VStack{
//                TextField(TextConstant.EMAIL, text: $email)
//                .padding()
//                    .background(ColorConstant.lightGreyColor)
//                .cornerRadius(5.0)
//                .padding(.bottom,20)
//                SecureField(TextConstant.PASSWORD,text:$password)
//                    .padding()
//                    .background(ColorConstant.lightGreyColor)
//                    .cornerRadius(5.0)
//                    .padding(.bottom,20)
//                NavigationLink(destination: FoodChoiceList(), tag: 1, selection: self.$selection){
//                    Button(action: {
//                        logIn()
//                    }, label: {
//                        Text(TextConstant.LOGIN)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(width: 220, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .background(ColorConstant.ROSE)
//                            .cornerRadius(15.0)
//                    })
//                }
//                .alert(isPresented: self.$showAlert) {
//                    Alert(title:Text(AlertMessage.ERROR), message: Text(AlertMessage.LOGIN_ERROR), dismissButton: .cancel())
//                }
//            }
//            .navigationTitle("").navigationBarHidden(true)
//
//        }.padding()
    }
    
    
    func logIn(){
        if (Helper.textFieldValidatorEmail(self.email) && self.password != "") {
            FirebaseAuthManager().signIn(email: self.email, password: self.password) { (success) in
                if success{
                    self.isLoginSuccess = true
                    print("success")
                }else{
                    self.showAlert = true
                }
            }
        }else{
            self.showAlert = true
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
