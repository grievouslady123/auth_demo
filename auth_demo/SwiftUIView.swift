//
//  SwiftUIView.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/11/14.
//

import SwiftUI
import Firebase

struct SwiftUIView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        
        VStack {
            Image("logo")
                .resizable()
                .frame(width:300,height: 75)
                .offset(x:0,y: -240)
            TextField("Email", text: $email)
                .foregroundColor(Color.green)
            SecureField("Password", text: $password)
                .foregroundColor(Color.green)
            Button(action: {
                creatAccount(emailValue: email, passwordValue: password)
            }){
                Image("登入")
                    .resizable()
                    .frame(width:150,height: 40)
                    
            }.offset(x:0,y: 240)
            NavigationLink{
                SignIn()
            }label: {
               
                    Image("button")
                        .resizable()
                        .frame(width:150,height: 75)
                        
                       

            } .offset(x:0,y: 250)
            
            
        }
        
        .background(Image("龍門")
            .resizable()
            .frame(width: 395,height: 600))
        .offset(x:0,y: 0)

    }
    func creatAccount(emailValue:String,passwordValue:String){
        Auth.auth().createUser(withEmail: emailValue, password: passwordValue){result, error in
            if error != nil{
                print(error?.localizedDescription ?? "")
            }else{
                print(result?.description ?? "")
                
            }
        }
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password)
        {(result,error) in
            if error != nil{
                print(error?.localizedDescription ?? "")
            }else{
                print("success")
            }
            
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
