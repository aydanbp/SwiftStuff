//
//  MainTabView.swift
//  Mortgage
//
//  Created by Philip Trwoga on 14/10/2024.
//

import SwiftUI


struct MainTabView: View {
    var body: some View {
        TabView {
            MortgageMainView().tabItem {
                Text("Mortgage")
                Image(systemName:"sterlingsign")
            }
            QuotesView().tabItem {
                Text("History")
                Image(systemName: "calendar")
            }
            
        }
    }
}

#Preview {
    MainTabView()
}
