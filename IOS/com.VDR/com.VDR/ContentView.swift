//
//  ContentView.swift
//  com.VDR
//
//  Created by Abhra Ghosh on 07/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some View {
        Group {
            if sessionManager.currentUser != nil {
                MainView()
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
