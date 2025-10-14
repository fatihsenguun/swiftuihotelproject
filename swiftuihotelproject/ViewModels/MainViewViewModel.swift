//
//  MainViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//
import FirebaseAuth
import Foundation
class MainViewViewModel:ObservableObject{
    @Published var currentUserId:String=""
    init(){
        Auth.auth().addStateDidChangeListener{[weak self]_, user in
            DispatchQueue.main.async{
                self?.currentUserId=user?.uid ?? ""
            }
    }
    }
    
    public var isSignedIn:Bool{
        return Auth.auth().currentUser != nil
    }
    
}
