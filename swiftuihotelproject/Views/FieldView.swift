//
//  FieldView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 4.10.2025.
//



import SwiftUI

struct FieldView: View {
    let name: String
    let textFieldName: String
    let text: Binding<String>
    let type: Int
  
    var body: some View {
        if type == 1 {
            Text(name)
                .font(.system(size: 13))
                .foregroundColor(.black)
            TextField(textFieldName, text: text)
                .padding()
                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                .cornerRadius(15)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        } else {
            Text(name)
                .font(.system(size: 13))
                .foregroundColor(.black)
            SecureField(textFieldName, text: text)
                .padding()
                .background(Color(red: 230/255, green: 230/255, blue: 230/255)) 
                .cornerRadius(15)
                .foregroundColor(.black)
                .autocapitalization(.none)
                .autocorrectionDisabled()
        }
    }
}

#Preview {
    
}
