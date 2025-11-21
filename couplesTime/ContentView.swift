//
//  ContentView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            FinancesView()
                .tabItem {
                    Label("Finances", systemImage: "dollarsign.circle.fill")
                }
            
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
