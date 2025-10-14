//
//  HotelItemView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct HotelItemView: View {
    var hotel: Hotel
    @Binding var selectedTab: Int
    @State private var showBooking = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "FFF9F2"), Color(hex: "FCEAC9")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    TabView {
                        ForEach(hotel.imageName, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipped()
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                                .padding(.horizontal)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 320)
                    .padding(.top, 15)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(hotel.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "3E2C1C"))
                                
                                Text(hotel.location)
                                    .font(.subheadline)
                                    .foregroundColor(Color(hex: "6B4F3A"))
                            }
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                HStack(spacing: 3) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: index < hotel.stars ? "star.fill" : "star")
                                            .foregroundColor(index < hotel.stars ? Color(hex: "FFD700") : .gray.opacity(0.4))
                                    }
                                }
                                Text("⭐️ \(hotel.stars).0")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Divider()
                            .padding(.vertical, 5)
                        
                        Text("Average price per night")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("$\(hotel.price)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(hex: "3E2C1C"))
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("About This Hotel")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "3E2C1C"))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(hotel.amenities, id: \.self) { amenity in
                                HStack(spacing: 10) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(hex: "FFD700"))
                                    Text(amenity)
                                        .foregroundColor(Color(hex: "3E2C1C"))
                                }
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    .padding(.horizontal)
                    
                    Button(action: {
                        showBooking.toggle()
                    }) {
                        Text("Book Now")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "3E2C1C"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "FFD700"), Color(hex: "F7C948")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            .padding(.horizontal)
                    }
                    .sheet(isPresented: $showBooking) {
                        BookNowView(hotel: hotel, selectedTab: $selectedTab)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    HotelItemView(
        hotel: Hotel(
            id: "1",
            name: "Sunset Paradise",
            location: "Antalya, Turkey",
            stars: 5,
            price: 250,
            imageName: ["hotel1", "hotel2", "hotel3"],
            amenities: ["Free Wi-Fi", "Swimming Pool", "Breakfast Included", "Sea View", "Spa & Wellness"],
            rooms: [Room(type: "Standard", price: 100)]
        ),
        selectedTab: .constant(0)
    )
}
