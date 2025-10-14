//
//  ProfileViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation


class ProfileViewViewModel : ObservableObject {
  
    func logOut() {
        do {
            try Auth.auth( ).signOut()
        }
        catch{}
    }
    
}
