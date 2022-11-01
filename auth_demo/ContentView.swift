//
//  PreView.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/11/14.
//

import SwiftUI
import Firebase
import Foundation
struct ContentView: View {
    @EnvironmentObject var sdm:StudentManager
    @State var ShowPopup = false
    @State var TheFirst = false
    @State var TheScond = false
    @State var statusIsLogin = true
    @State var email = ""
    @State var searchName = ""
    @State var password = ""
    @State var message = ""
    @State var name = ""
    @State var isSecured:Bool = true
    var body: some View {
        VStack{
            HStack {
                TextField("搜尋好友",text: $searchName)
                Button{
                    sdm.findStudent(name: searchName)
                }label: {
                    Text("搜尋")
                }
            }.padding()
            
            if statusIsLogin{
                NavigationView{
                    
                    List(sdm.students,id: \.id){ std in
                        VStack(alignment:.leading){
                            
                            HStack{
                                HStack{
                                    Text(std.image)
                                        .foregroundColor(Color.white)
                                        .frame(width: 50 ,height: 50)
                                        .background(Color.black)
                                        .cornerRadius(100)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 100)
                                                .stroke(Color.yellow ,lineWidth: 3)
                                        }
                                    Image(std.name)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    Text(std.id)
                                    Text(std.name)
                                        .frame(width: 50)
                                }
                                
                                HStack{
                                    Text("最近上線日期：")
                                    Text(" 今日")
                                        .frame(width:   100 ,height: 20)
                                        .background(Color.blue)
                                        .cornerRadius(100)
                                    
                                    NavigationLink{
                                        Test(name: std.name,id: std.id)
                                    }label: {
                                        Image( "名片")
                                    }
                                    
                                    Button{
                                        sdm.deleteStudent(id:std.dID)
                                    }label: {
                                        Text("delete ")
                                    }
                                    
                                }
                            }
                        }.listRowBackground(Color.gray)
                        
                        
                        
                    }
                    
                    
                    .navigationTitle("好友列表")
                    .navigationBarItems(trailing: Button(action: { ShowPopup.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }))
                    .sheet(isPresented: $ShowPopup){
                        NewStudent(ShowPopup:$ShowPopup)
                        
                    }
                    
                }
                
            }else{
                VStack{
                    Text("message = \(message)")
                    Text("輸入帳號密碼")
                    TextField("Email",text: $email)
                    SecureField("password", text: $password)
                    withAnimation{
                        Button(action: {
                            creatAccount(emailValue: email,passwordValue: password)
                            login()
                            statusIsLogin.toggle()
                        }){
                            Text("登入")
                        }
                    }            }
            }
            
            
            
        }
        
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(StudentManager())
    }
}
