//
//  RestaurantAnnotations.swift
//  DineFinder
//
//  Created by Aydan Buncombe-Paul on 23/04/2025.
//

import Foundation
import MapKit

struct RestaurantAnnotations: Identifiable {
    var id = UUID()
    var bID: Business?
    var name: String
    var location: CLLocationCoordinate2D
    var streetName: String
    var cuisine: String
    var visited: Bool

    init(name: String, location: CLLocationCoordinate2D, streetName: String, cuisine: String, visited: Bool = false, biD: Business? = nil) {
        self.name = name
        self.location = location
        self.cuisine = cuisine
        self.visited = visited
        self.streetName = streetName
        self.bID = biD
    }

}
