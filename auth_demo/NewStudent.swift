//
//  NewStudent.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/11/22.
//

import SwiftUI

struct NewStudent: View {
    @EnvironmentObject var studentManager:StudentManager
    @State private var name = ""
    @Binding var ShowPopup:Bool
    var body: some View {
        VStack{
            TextField("名稱" ,text: $name)
            Button{
                studentManager.addStudent(name: name)
                ShowPopup.toggle()
            }label: {
                Text("儲存")
            }
            
        }
    }
}

struct NewStudent_Previews: PreviewProvider {
    static var previews: some View {
        NewStudent(ShowPopup: .constant(false)).environmentObject(StudentManager())
    }
}

