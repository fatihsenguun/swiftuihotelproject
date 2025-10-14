//
//  AddHotelViewModel.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 7.10.2025.
//

import Foundation
import FirebaseFirestore

public func addSampleHotels() {
    let db = Firestore.firestore()
    let hotels = [
        Hotel(
            id: UUID().uuidString,
            name: "Seaside Resort",
            location: "Antalya, Turkey",
            stars: 5,
            price: 180,
            imageName: ["hotel1", "hotel2", "hotel3"],
            amenities: ["Pool", "Spa", "WiFi", "Restaurant", "Gym"],
            rooms: [
                Room(type: "Standard", price: 150),
                Room(type: "Deluxe", price: 200),
                Room(type: "Suite", price: 350)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "Mountain View Hotel",
            location: "Trabzon, Turkey",
            stars: 4,
            price: 140,
            imageName: ["hotel2", "hotel3", "hotel1"],
            amenities: ["WiFi", "Breakfast", "Parking"],
            rooms: [
                Room(type: "Standard", price: 120),
                Room(type: "Deluxe", price: 160)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "City Center Inn",
            location: "Istanbul, Turkey",
            stars: 3,
            price: 110,
            imageName: ["hotel3", "hotel1", "hotel2"],
            amenities: ["WiFi", "Restaurant"],
            rooms: [
                Room(type: "Economy", price: 90),
                Room(type: "Business", price: 130)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "Lakeside Retreat",
            location: "Sapanca, Turkey",
            stars: 5,
            price: 220,
            imageName: ["hotel1", "hotel3"],
            amenities: ["Lake View", "Sauna", "WiFi", "Breakfast Included"],
            rooms: [
                Room(type: "Deluxe Lake View", price: 260),
                Room(type: "Standard", price: 190)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "Historic Palace Hotel",
            location: "Istanbul, Turkey",
            stars: 5,
            price: 300,
            imageName: ["hotel2", "hotel1"],
            amenities: ["Spa", "Fine Dining", "WiFi", "Butler Service"],
            rooms: [
                Room(type: "Suite", price: 400),
                Room(type: "Deluxe", price: 320)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "Cappadocia Cave Suites",
            location: "Nevşehir, Turkey",
            stars: 4,
            price: 190,
            imageName: ["hotel3", "hotel1"],
            amenities: ["Cave Rooms", "Breakfast Included", "WiFi", "Terrace View"],
            rooms: [
                Room(type: "Cave Suite", price: 210),
                Room(type: "Classic", price: 170)
            ]
        ),
        Hotel(
            id: UUID().uuidString,
            name: "Blue Aegean Resort",
            location: "Bodrum, Turkey",
            stars: 5,
            price: 240,
            imageName: ["hotel1", "hotel2"],
            amenities: ["Beach Access", "All Inclusive", "WiFi", "Pool", "Spa"],
            rooms: [
                Room(type: "Standard", price: 220),
                Room(type: "Deluxe Sea View", price: 280)
            ]
        )
    ]
  
    for hotel in hotels {
        do {
            try db.collection("hotels").document(hotel.id).setData(from: hotel)
            print("✅ \(hotel.name) added successfully")
        } catch {
            print("❌ Error adding \(hotel.name): \(error.localizedDescription)")
        }
    }
}
