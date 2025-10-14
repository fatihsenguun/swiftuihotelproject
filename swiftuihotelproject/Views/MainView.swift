//
//  ContentView.swift
//  swiftuihotelproject
//
//  Created by Fatih Sengun on 3.10.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel=MainViewViewModel()
    @State  var selectedTab = 0
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }.tag(0)
                SelectView(selectedTab: $selectedTab)
                    .tabItem{
                        Label("Hotels", systemImage: "building.2")
                    }.tag(1)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }.tag(2)
            }
        }else{
            LoginView()
        }
        }
        
    }


#Preview {
    MainView()
}
