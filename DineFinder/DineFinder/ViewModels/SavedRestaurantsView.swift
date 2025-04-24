//
//  Saved.swift
//  CourseworkProofOConcept
//
//  Created by Aydan Buncombe-Paul on 05/04/2025.
//

import SwiftUI
import SwiftData

struct SavedRestaurantsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var saved : [SavedModel]
    @EnvironmentObject var DarkMode: Themes
    var body: some View {
        VStack {
            Text("Saved")
                .font(.headline)
            List (saved){ item in
                @State var testbool : Bool = true
                VStack(alignment: .leading){
                    
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("\(item.name)")
                        Text("\(item.roadName)")
                        Spacer()
                            Button("", systemImage: "trash"){
                                
                            }
                            .onTapGesture {modelContext.delete(item)}
                            .foregroundStyle(.red)
                            
                            
                            Button("",systemImage: "mappin.and.ellipse"){
                                
                            }
                            
                            
                        
                    }
                }
            }
        }
        .background(DarkMode.isDarkModeEnabled
                    ?Color.black //true
                    :Color.white //false
        )
        .colorScheme(DarkMode.isDarkModeEnabled
                     ?.dark
                     :.light
        )
    }
    
}
#Preview {
    SavedRestaurantsView()
}


