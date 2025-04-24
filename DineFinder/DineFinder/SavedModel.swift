//
//  SavenModel.swift
//  CourseworkProofOConcept
//
//  Created by Aydan Buncombe-Paul on 19/04/2025.
//


import Foundation
import MapKit
import SwiftData

@Model class SavedModel: Identifiable {
    var selected: Bool = false
    var name: String
    var location: String
    var roadName: String

    init(name: String, location: String, roadName: String) {
       self.name = name
       self.location = location
        self.roadName = roadName
    }
 }
