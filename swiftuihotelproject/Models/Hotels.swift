//
//  Hotels.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 6.10.2025.
//


import Foundation

struct Room: Codable {
    let type: String
    let price: Double
}

struct Hotel: Identifiable, Codable {
    let id: String
    let name: String
    let location: String
    let stars: Int
    let price: Int
    let imageName: [String]
    let amenities: [String]
    let rooms: [Room]
}
