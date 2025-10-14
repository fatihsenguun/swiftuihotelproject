//
//  BookNowViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 9.10.2025.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookNowViewViewModel: ObservableObject {
    @Published var bookedHotel: Hotel? = nil
    @Published var nowDate: Date = Date()
    

    
    init() {}
    
    
    func updateData(hotel: String, checkoutDate: TimeInterval, roomId: String){
        guard let userId = Auth.auth().currentUser?.uid else { return }
          let db = Firestore.firestore()   
          db.collection("users").document(userId).updateData([
             "currentHotelId": hotel ,
             "reservationEndDate": checkoutDate,
             "currentRoomId" : roomId
          ])
        if checkoutDate<Date().timeIntervalSince1970{
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
        
            let db = Firestore.firestore()
            db.collection("users").document(userId).updateData([
                "currentHotelId": "",
                "reservationEndDate": "",
                "currentRoomId" : ""])
        }
      
        

      }
    
   
    }
    


