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
    @State var selection: Int? = nil

    
    var body: some View {
        NavigationView{
            VStack{
                TextField(TextConstant.EMAIL, text: $email)
                .padding()
                    .background(ColorConstant.lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom,20)
                SecureField(TextConstant.PASSWORD,text:$password)
                    .padding()
                    .background(ColorConstant.lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom,20)
                NavigationLink(destination: FoodChoiceList(), tag: 1, selection: self.$selection){
                    Button(action: {
                        logIn()
                    }, label: {
                        Text(TextConstant.LOGIN)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(ColorConstant.ROSE)
                            .cornerRadius(15.0)
                    })
                }
                .alert(isPresented: self.$showAlert) {
                    Alert(title:Text(AlertMessage.ERROR), message: Text(AlertMessage.LOGIN_ERROR), dismissButton: .cancel())
                }
            }
            .navigationTitle("").navigationBarHidden(true)

        }.padding()
    }
    
    
    func logIn(){
        if (Helper.textFieldValidatorEmail(self.email) && self.password != "") {
            FirebaseAuthManager().signIn(email: self.email, password: self.password) { (success) in
                if success{
                    self.selection = 1
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
