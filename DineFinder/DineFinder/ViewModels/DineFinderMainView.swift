//
//  ContentView.swift
//  DineFinder
//
//  Created by Ana 😋 & Aydan Buncombe-Paul on 23/04/2025.
//

import SwiftUI
import MapKit
import SwiftData
import CoreLocation

struct DineFinderMainView: View {
    @Environment(\.modelContext) var modelContext
    @Query var saved: [SavedModel]
    @ObservedObject var mapViewModel = MapViewModel()
    @EnvironmentObject var DarkMode: Themes
    //@State var Query: String = ""
    @State private var mapLocation = ""
    
    @State var coordinates: CLLocationCoordinate2D?
    
    @StateObject private var locationManager = LocationManager()
    @State private var selectedRestaurant: Business? = nil
    @State private var query: String = ""
    @State private var restaurants: [Business] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5072, longitude: -0.1276), // ✅ London
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    
    var body: some View {
        VStack {
            HStack {
                //SEARCH BAR
                Text("Search")
                TextField("e.g. sushi, burgers, pizza", text: $query)
                    .padding()
                TextField("location", text: $mapLocation)
                    .padding(.leading)
                    .onSubmit {
                        
                        Task{
                            do {
                                try await mapViewModel.getCoordinates(query: query, locale: mapLocation)
                                try await mapViewModel.setAnnotations(query: query)
                                
                            }
                            catch {
                                print("Error: \(error)")
                            }
                            
                            
                        }
                        mapViewModel.mapLocation = mapLocation
                    }
            }
            .padding()
            .cornerRadius(20)
            .border(Color.black)
            
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: mapViewModel.annotations) { restaurant in
                MapAnnotation(coordinate: restaurant.location) {
                    Button {
                        selectedRestaurant = restaurant.bID
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "fork.knife.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                                .background(Color.white)
                            
                            Text(restaurant.name)
                                .font(.caption)
                                .frame(width: 100)
                                .lineLimit(1)
                                .fontWeight(.bold)
                        }
                    }
                }
                
            }
            .sheet(item: $selectedRestaurant) { restaurant in
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: restaurant.image_url)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                    
                    Text(restaurant.name)
                        .font(.title2)
                        .bold()
                    
                    Text("Rating: \(restaurant.rating, specifier: "%.1f") ⭐️")
                        .font(.subheadline)
                    
                    if let address = restaurant.location.address1 {
                        Text(address)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            VStack {
                List (mapViewModel.annotations){ item in
                    HStack{
                        Button("Add"){
                            let a = RestaurantModel(name: item.name, location: "location temp data", streetName: "" , cuisine: item.cuisine , visited: false)
                            modelContext.insert(a)
                            
                        }
                        Text(item.name)
                        Spacer()
                        Text("\(item.location.latitude), \(item.location.longitude)")
                    }
                    
                    
                    
                }
            }
            .cornerRadius(20)
        }
        .cornerRadius(20)
        
        
        
        // MARK: - Restaurant Sheet
        
        
        // MARK: - Styling + Initial Search
        .padding()
        .background(DarkMode.isDarkModeEnabled ? Color.black : Color.white)
        .colorScheme(DarkMode.isDarkModeEnabled ? .dark : .light)
        
        
        
        
        .padding()
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

