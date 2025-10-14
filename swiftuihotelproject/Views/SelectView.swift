//
//  TodoListView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct SelectView: View {
    @State var showFilter: Bool = false
    @StateObject var viewModel = SelectViewViewModel()
    @Binding var selectedTab: Int

    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan
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
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        
                       
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Find Your Perfect Stay")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "3E2C1C"))
                                Text("Choose from top hotels")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Button {
                                showFilter.toggle()
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: "slider.vertical.3")
                                    Text("Filter")
                                }
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    LinearGradient(
                                        colors: [Color(hex: "D4AF37"), Color(hex: "C19A36")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                            }
                            .buttonStyle(.plain)
                            .sheet(isPresented: $showFilter) {
                                ShowFilterView()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 15)
                        
                        
                        LazyVStack(spacing: 25) {
                            ForEach(viewModel.hotels, id: \.id) { hotel in
                                NavigationLink(destination: HotelItemView(hotel: hotel, selectedTab: $selectedTab)) {
                                    ZStack(alignment: .bottomLeading) {
                                        
                                     
                                        TabView {
                                            ForEach(hotel.imageName, id: \.self) { imageName in
                                                Image(imageName)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(height: 280)
                                                    .cornerRadius(30)
                                                    .clipped()
                                            }
                                        }
                                        .tabViewStyle(.page)
                                        .frame(height: 280)
                                        .cornerRadius(30)
                                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                                        
                                      
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(hotel.name)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            HStack(spacing: 2) {
                                                ForEach(0..<5) { index in
                                                    Image(systemName: index < hotel.stars ? "star.fill" : "star")
                                                        .foregroundColor(index < hotel.stars ? .yellow : .white.opacity(0.5))
                                                }
                                            }
                                            
                                            Text(hotel.location)
                                                .font(.subheadline)
                                                .foregroundColor(.white.opacity(0.9))
                                            
                                            HStack {
                                                Text("$\(hotel.price) / night")
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Text("Book Now")
                                                    .font(.callout)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(hex: "3E2C1C"))
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 14)
                                                    .background(
                                                        LinearGradient(
                                                            colors: [Color(hex: "FFD700"), Color(hex: "E6C200")],
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        )
                                                    )
                                                    .cornerRadius(20)
                                            }
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(30)
                                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
                                    }
                                    .padding(.horizontal)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
                .onAppear {
                    viewModel.fetchHotels()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SelectView(selectedTab: .constant(0))
}
