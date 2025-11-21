//
//  ProfileView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}

