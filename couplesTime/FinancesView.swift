//
//  FinancesView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

struct FinancesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Finances")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle("Finances")
        }
    }
}

#Preview {
    FinancesView()
}

