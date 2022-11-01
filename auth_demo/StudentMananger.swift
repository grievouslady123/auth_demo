//
//  StudentMessenger.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/11/21.
//

import SwiftUI
import Firebase

class StudentManager: ObservableObject{
    @Published var students:[Student] = []
    
    init(){
        fetechStudents()
    }
    func fetechStudents(){
        students.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("Student")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for ducument in snapshot.documents {
                    let date = ducument.data()
                    
                    let id = date["id"] as? String ?? ""
                    let name = date["name"] as? String ?? ""
                    let image = date["image"] as? String ?? ""
                    let dID = ducument.documentID
                    let student = Student(id: id, name: name,image: image,dID: dID)
                    
                    self.students.append(student)
                }
            }
        }
        
        
        
        
    }
    func addStudent(name:String){
        let db = Firestore.firestore()
        let ref = db.collection("Student").document()
        ref.setData(["name": name,"id":UUID().uuidString]){error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        
        fetechStudents()
    }
    func deleteStudent(id:String){
        let db = Firestore.firestore()
        db.collection("Student").document(id).delete()
        fetechStudents()
    }
    func findStudent(name:String){
        students.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Student")
        ref.whereField("name", isEqualTo: name).getDocuments(){snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let date = document.data()
                    let id = date["id"]as? String ?? ""
                    let name = date["name"]as? String ?? ""
                    let image = date["image"] as? String ?? ""
                    let dID = date["dID"] as? String ?? ""
                    let student = Student(id: id, name: name,image: image,dID: dID)
                    
                    self.students.append(student)
                }
                
            }
            
        }
        
        
    }
}
