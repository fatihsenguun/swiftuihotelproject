//
//  ProfileView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @StateObject var viewModel2 = HomeViewViewModel()

    var body: some View {
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

            VStack(spacing: 25) {
                VStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 110))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(hex: "D4AF37"), Color(hex: "B8860B")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                        .padding(.top, 40)

                    Text(viewModel2.firstName.isEmpty ? "Guest" : viewModel2.firstName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(hex: "3E2C1C"), Color(hex: "6B4F3A")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    Text(viewModel2.email.isEmpty ? "example@email.com" : viewModel2.email)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "6B4F3A"))
                }

                VStack(spacing: 15) {
                    ProfileInfoRow(title: "Hotel", value: viewModel2.checkOutDate2 == nil ? "No Hotel Selected" : viewModel2.hotelName)
                    ProfileInfoRow(title: "Room ID", value: viewModel2.roomId ?? "—")
                    ProfileInfoRow(
                        title: "Check-out",
                        value: viewModel2.checkOutDate2 != nil
                            ? DateFormatter.localizedString(from: viewModel2.checkOutDate2!, dateStyle: .medium, timeStyle: .none)
                            : "—"
                    )


                }.onAppear{
                    viewModel2.fetchUserAndHotel() }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
                .padding(.horizontal, 25)
                .padding(.top, 10)

                Spacer()

                Button(action: { viewModel.logOut() }) {
                    Text("Log Out")
                        .font(.headline)
                        .fontWeight(.semibold)
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
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 25)
                }

                Spacer()
            }
        }
    }
}

struct ProfileInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "3E2C1C"))
            Spacer()
            Text(value)
                .foregroundColor(Color(hex: "6B4F3A"))
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
