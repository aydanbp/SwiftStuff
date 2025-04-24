
import Foundation
import SwiftUI
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    @Published var mapLocation: String = ""
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var annotations: [RestaurantAnnotations] = [] // Published property to hold place annotations.
    @Published var desired : String = ""
    
    
    @StateObject private var locationManager = LocationManager()
    @State private var selectedRestaurant: Business? = nil
    @State private var restaurants: [Business] = []
    func getCoordinates(query: String, locale : String) async throws {
        let geocoder = CLGeocoder()
        if let placemarks = try? await geocoder.geocodeAddressString(locale),
        let location = placemarks.first?.location?.coordinate {
            DispatchQueue.main.async {
                self.coordinates = location
                self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                print("📍 Searching near lat: \(location.latitude), long: \(location.longitude) for \(query)")
                let y = YelpService().fetchRestaurants(
                    term: query,
                    latitude: location.latitude,
                    longitude: location.longitude
                ) { fetched in
                    self.restaurants = fetched
                }
                
            }
        }
        //guard let location = locationManager.location
         else {
            print("📍 Location not available yet")
            return
        }

        //print("📍 Searching near lat: \(coordinates.latitude), long: \(coordinates.longitude) for \(query)")


    }
    func setAnnotations(query:String) async throws {
        let request = MKLocalSearch.Request()
        print("0...request:   ", request)
        request.naturalLanguageQuery = query
        request.region = region

        let search = MKLocalSearch(request: request)
        if let results = try? await search.start() {
            let items = results.mapItems
            print(items.count)
            for item in items {
                print("1...coordinate:  ",item.placemark.coordinate)
                print("2...name:  ",item.name ?? "undefined")
                print("3...item:  ", item)
                print("4...address:  ",item.placemark.thoroughfare, "Undefined")
            }
            DispatchQueue.main.async
            {
                self.restaurants = []
                self.annotations = []
                for item in items {
                    if let location = item.placemark.location?.coordinate {
                        let place = RestaurantAnnotations(name: item.name ?? "Undefined", location: location,streetName: item.placemark.thoroughfare ?? "Undefined", cuisine: "")
                        
                        self.annotations.append(place)
                    }
                }
            }

        }
    }
}



