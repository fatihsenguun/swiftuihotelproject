//
//  user.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let idNo: String
    let joined: TimeInterval
    var currentHotelId: String?       
    var reservationEndDate: TimeInterval?
    var currentRoomId: String?
}
