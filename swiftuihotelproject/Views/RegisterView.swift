//
//  RegisterView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
    
   
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        NavigationView {
            ZStack {
                
                Color(hex: "FFF9F2")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                   
                    Image("keyinn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 10)
                    
                  
                    Text("Register")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "3E2C1C"))
                    
                   
                    VStack(alignment: .leading, spacing: 10) {
                        
                       
                        FieldView(name: "Name", textFieldName: "Enter Your Full Name", text: $viewModel.name, type: 1)

                        FieldView(name: "ID / Passport No (Optional)", textFieldName: "Enter Your ID", text: $viewModel.idNo, type: 1)
                      
                        FieldView(name: "Email", textFieldName: "Enter Email", text: $viewModel.email, type: 1)
          
                        FieldView(name: "Password", textFieldName: "Enter Password", text: $viewModel.password, type: 2)
              
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(Color(hex: "FF4C4C"))
                                .font(.footnote)
                                .padding(.top, 5)
                        }
                        
                        
                        Button(action: {
                            viewModel.register()
                        }) {
                            Text("Register")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "D4AF37"))
                                .cornerRadius(15)
                        }
                        .padding(.top, 10)
                    }
                    .padding(20)
                    .background(Color(hex: "FFF4E6"))
                    .cornerRadius(30)
                    .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                    )
                    
                    Spacer()
                    
                   
                }
                .padding(.horizontal, 20)
                .frame(width: screenWidth * 0.85, height: screenHeight * 0.8)
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RegisterView()
}
