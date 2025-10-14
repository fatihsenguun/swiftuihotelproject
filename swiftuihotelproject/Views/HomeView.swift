//
//  HomeView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    @Binding var selectedTab: Int
    @StateObject var viewModel = HomeViewViewModel()
    @StateObject var viewModel2 = BookNowViewViewModel()
    @State private var showCancelAlert = false
    @State private var isPresentingScanner = false
    @State private var scannedCode: String = "Scan the QR code to unlock the door."
    @State private var lockStatus: String = "lock.fill"
    
    var body: some View {
        NavigationView {
            ZStack {
              
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "FFF9F2"),
                        Color(hex: "FFF2D6"),
                        Color(hex: "FCEAC9")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 35) {
                        
                        VStack(spacing: 6) {
                            Text("Welcome")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(Color(hex: "3E2C1C").opacity(0.8))
                            Text(viewModel.firstName.isEmpty ? "Guest" : viewModel.firstName)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(hex: "D4AF37"), Color(hex: "8B6E30")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        .padding(.top, 40)
                        
                       
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Your Reservation")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "3E2C1C"))
                                Spacer()
                                if viewModel.checkOutDate2 != nil {
                                    Label("Active", systemImage: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                }
                            }
                            
                            if viewModel.checkOutDate2 == nil {
                                VStack(spacing: 15) {
                                    Text("No hotel selected.")
                                        .foregroundColor(Color(hex: "3E2C1C"))
                                        .padding(.vertical, 4)
                                    Button {
                                        selectedTab = 1
                                    } label: {
                                        Text("Select Hotel")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color(hex: "D4AF37"))
                                            .foregroundColor(.white)
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(25)
                            } else {
                               
                                VStack(spacing: 18) {
                                    HStack(alignment: .center, spacing: 15) {
                                        Image(viewModel.hotelImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(20)
                                            .shadow(radius: 4)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(viewModel.hotelName)
                                                .font(.headline)
                                                .foregroundColor(Color(hex: "3E2C1C"))
                                            Text("Istanbul, Turkey")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                    
                                    Divider().padding(.vertical, 5)
                                    
                                    HStack {
                                        Text("Room")
                                            .font(.headline)
                                            .foregroundColor(Color(hex: "3E2C1C"))
                                        Spacer()
                                        Text(viewModel.roomId ?? "-")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(hex: "D4AF37"))
                                    }
                                    
                                    if let date = viewModel.checkOutDate2 {
                                        HStack {
                                            Text("Check-out:")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Text(viewModel.formattedDate(date))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color(hex: "3E2C1C"))
                                        }
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(25)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                      
                        if viewModel.checkOutDate2 != nil {
                            VStack(spacing: 20) {
                                VStack(spacing: 12) {
                                    Image(systemName: lockStatus)
                                        .font(.system(size: 50))
                                        .foregroundColor(Color(hex: "D4AF37"))
                                        .shadow(radius: 5)
                                    Text(scannedCode)
                                        .font(.callout)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(hex: "3E2C1C"))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(.ultraThinMaterial)
                                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                                )
                                
                                Button(action: { isPresentingScanner = true }) {
                                    HStack {
                                        Image(systemName: "qrcode.viewfinder")
                                        Text("Scan QR to Unlock")
                                    }
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            colors: [Color(hex: "3E2C1C"), Color(hex: "5B3E25")],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                                }
                                
                                Button(role: .destructive) {
                                    showCancelAlert = true
                                } label: {
                                    HStack(spacing: 5) {
                                        Image(systemName: "xmark.circle.fill")
                                        Text("Cancel Reservation")
                                    }
                                    .font(.callout)
                                }
                                .alert("Cancel Reservation", isPresented: $showCancelAlert) {
                                    Button("Yes, Cancel", role: .destructive) {
                                        viewModel2.updateData(hotel: "", checkoutDate: 0, roomId: "")
                                    }
                                    Button("No", role: .cancel) {}
                                } message: {
                                    Text("Are you sure you want to cancel your reservation?")
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 60)
                }
            }
            .onAppear { viewModel.fetchUserAndHotel() }
            .onDisappear { viewModel.stopListening() }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { result in
                    switch result {
                    case .success(let code):
                        if(code.string == "ROOM_300_TEST"){
                            scannedCode = "The door is unlocked ✅"
                            lockStatus = "lock.open.fill"
                        }else{
                            scannedCode = "Invalid QR code."
                        }
                    case .failure(let error):
                        scannedCode = "QR scan failed: \(error.localizedDescription)"
                    }
                    isPresentingScanner = false
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
