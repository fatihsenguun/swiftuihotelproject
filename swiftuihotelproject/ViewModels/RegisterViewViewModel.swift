//
//  RegisterViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation


class RegisterViewViewModel:ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name:String=""
    @Published var idNo:String=""
    @Published var errorMessage: String=""
  
    init(){ }
    func register(){
        guard validate() else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let userId=result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
            
        }
    }
    private func insertUserRecord(id:String){
        let newUser=User(id: id, name: name, email: email, idNo: idNo, joined: Date().timeIntervalSince1970, currentHotelId: "sad", reservationEndDate: nil , currentRoomId: nil)
        
        let db=Firestore.firestore()
        db.collection("users").document(id).setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage=""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{errorMessage="Please enter your name, email and password."
            return false}
        
        guard email.contains("."),
              email.contains("@")
        else {
            errorMessage="Invalid email format."
            return false
        }
        guard (password.count >= 6) else {
            errorMessage="Password must be at least 6 characters long."
            return false
        }
        return true
    }
    
    
}
