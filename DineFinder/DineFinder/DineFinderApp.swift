//
//  DineFinderApp.swift
//  DineFinder
//
//  Created by Aydan Buncombe-Paul on 23/04/2025.
//

import SwiftUI
import SwiftData

@main
struct CourseworkProofOConceptApp: App {
    
    var body: some Scene {
        let colours = Themes()
        WindowGroup {
            MainTabView().environmentObject(colours)
        }
        .modelContainer(for: SavedModel.self)
    }
}
class Themes : ObservableObject {
    @Published var isDarkModeEnabled : Bool = false
}
