//
//  BookNowView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 9.10.2025.
//

import SwiftUI

struct BookNowView: View {
   
    var hotel: Hotel
  
    @Binding var selectedTab: Int
   
    @StateObject var viewModel = BookNowViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
   
    @State private var checkInDate = Date()
    @State private var checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    
    @State private var guestCount = 1
    @State private var showConfirmation = false
    

    var totalPrice: Int {
        let nights = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate).day ?? 1
        return nights * hotel.price * guestCount
    }
        
    var body: some View {
        ZStack {
           
            Color(hex: "FAF7F0").ignoresSafeArea()
            
            VStack(spacing: 30) {
                
               
                VStack(spacing: 8) {
                    Text("Booking at")
                        .font(.headline)
                        .foregroundColor(Color(hex: "6B4F3A"))
                    
                    Text(hotel.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "3E2C1C"))
                }
                
               
                VStack(alignment: .leading, spacing: 20) {
                    
                   
                    Group {
                        Text("Reservation Dates")
                            .font(.headline)
                            .foregroundColor(Color(hex: "3E2C1C"))
                        
                        DatePicker("Check-in", selection: $checkInDate, displayedComponents: .date)
                        DatePicker("Check-out", selection: $checkOutDate, in: checkInDate..., displayedComponents: .date)
                    }
                    
                    Divider()
                    
                   
                    Text("Number of Guests")
                        .font(.headline)
                        .foregroundColor(Color(hex: "3E2C1C"))
                    
                    HStack(spacing: 20) {
                       
                        Button(action: {
                            if guestCount > 1 { guestCount -= 1 }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                                .foregroundColor(Color(hex: "3E2C1C"))
                        }
                        
                       
                        Text("\(guestCount)")
                            .font(.title2)
                            .frame(width: 40)
                        
                      
                        Button(action: {
                            guestCount += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(Color(hex: "FFD700"))
                        }
                    }
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Price Summary")
                            .font(.headline)
                            .foregroundColor(Color(hex: "3E2C1C"))
                        
                        Text("Total: $\(totalPrice)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "6B4F3A"))
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .padding(.horizontal)
                
              
                Button(action: {
                    
                    let hotelId = hotel.id
                    let checkOutTimeInt = checkOutDate.timeIntervalSince1970
                    
                   
                    viewModel.updateData(hotel: hotelId, checkoutDate: checkOutTimeInt, roomId: "300")
                    
                  
                    showConfirmation = true
                }) {
                    Text("Confirm Reservation")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "3E2C1C"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "FFD700"))
                        .cornerRadius(25)
                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    
                }
               
                .sheet(isPresented: $showConfirmation) {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)
                        
                        Text("Your hotel reservation has been confirmed!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Go to Home") {
                            presentationMode.wrappedValue.dismiss() 
                            showConfirmation = false
                            selectedTab = 0
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "FFD700"))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    BookNowView(
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
