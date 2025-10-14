//
//  LoginViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//
import FirebaseAuth
import Foundation
class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String=""
    init(){}
    
    func login(){
        guard validate() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            print("Login successful")
        }
            
        }
    
    func validate() ->Bool {
    
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter your email and password."
            return false
        }
       
        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Invalid email format."
            return false
        }

        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters."
            return false
        }

        errorMessage = ""
        return true
    }

        
    
    
    
    
    
}
