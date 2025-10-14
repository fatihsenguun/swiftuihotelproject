//
//  LoginView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        NavigationView {
            ZStack {
             
                LinearGradient(
                    colors: [Color(hex: "FFF9F2"), Color(hex: "FCEAC9")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    
                    Image("keyinn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .padding(.top, 40)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

                    
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "3E2C1C"))
                        .padding(.bottom, 10)
                    
                    Text("Sign in to continue")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "6B4F3A"))
                    
                    Spacer(minLength: 10)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        FieldView(name: "Email", textFieldName: "Enter your email", text: $viewModel.email, type: 1)
                            .padding(.vertical, 4)
                    
                            .cornerRadius(12)
                        
                        FieldView(name: "Password", textFieldName: "Enter your password", text: $viewModel.password, type: 2)
                            .padding(.vertical, 4)
                         
                            .cornerRadius(12)
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .padding(.top, 4)
                        }

                        Button(action: { viewModel.login() }) {
                            HStack {
                                Spacer()
                                Text("Login")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "3E2C1C"))
                                Spacer()
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "FFD700"), Color(hex: "F7C948")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                            .padding(.top, 10)
                        }
                    }
                    .padding(25)
                    .background(.ultraThinMaterial)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 20)

                    Spacer()
                    
                   
                    VStack(spacing: 5) {
                        Text("Don’t have an account?")
                            .foregroundColor(Color(hex: "3E2C1C"))
                            .font(.subheadline)
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Create Account")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "D4AF37"))
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
