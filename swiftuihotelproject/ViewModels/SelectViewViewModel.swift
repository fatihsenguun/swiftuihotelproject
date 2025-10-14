//
//  TodoListViewViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//


import Foundation
import FirebaseFirestore
import SwiftUI

final class SelectViewViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var hotels: [Hotel] = []
    
    func fetchHotels() {
        db.collection("hotels").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching hotels: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.hotels = documents.compactMap { doc in
                try? doc.data(as: Hotel.self)
            }
            
            print("✅ Fetched hotels: \(self.hotels)")
        }
    }
    
    
    
    
}


