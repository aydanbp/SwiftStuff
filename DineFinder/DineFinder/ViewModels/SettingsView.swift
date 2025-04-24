//
//  SettingsView.swift
//  CourseworkProofOConcept
//
//  Created by Aydan Buncombe-Paul on 05/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var DarkMode: Themes
    @State var ApTog: Bool = false
    var body: some View {
        VStack {
            Text("Settings View").font(.headline)
            
                List{
                    
                    Toggle("Dark Mode", isOn: $DarkMode.isDarkModeEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    
                
                    /*Section{
                        HStack{
                            Image(systemName: "icloud.fill")
                            Text("iCloud")
                        }
                        
                        HStack{
                            
                            Image(systemName: "airplane")
                            Spacer(minLength: 10)
                            Text("Airplane Mode")
                            Toggle("", isOn: $ApTog)
                            
                                
                            
                                
                        }
                        HStack{
                            Image(systemName: "wifi")
                            Text("Wi-Fi")
                                
                                Spacer()
                            
                            Text("eduroam")
                                .multilineTextAlignment(.leading)
                            Image(systemName: "chevron.right")
                        }
                        .onTapGesture {
                            Text("Hello")
                        }
                        HStack{
                            Image(systemName: "globe")
                            Text("Bluetooth")
                            Spacer()
                        
                        Text("On")
                            .multilineTextAlignment(.leading)
                        Image(systemName: "chevron.right")
                        }
                        
                        HStack{
                            Image(systemName: "cellularbars")
                            Text("Mobile Service")
                            Spacer()
                        Image(systemName: "chevron.right")
                        }
                        HStack{
                            Image(systemName: "link")
                            Text("Personal Hotspot")
                            
                            Spacer()
                        
                        Text("On")
                            .multilineTextAlignment(.leading)
                        Image(systemName: "chevron.right")
                        }
                        HStack{
                            Image(systemName: "battery.100")
                            Text("Battery")
                            
                            Spacer()
                        Image(systemName: "chevron.right")
                        }
                        
                    }*/
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

