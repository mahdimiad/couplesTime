//
//  HomeView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}

