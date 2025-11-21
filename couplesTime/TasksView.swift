//
//  TasksView.swift
//  couplesTime
//
//  Created by Mahdi Miad on 21/11/2025.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Tasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    TasksView()
}

