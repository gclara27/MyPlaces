//
//  Place.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

import MapKit

enum PlacesTypes:Int, Codable {
    case GenericPlace = 0
    case TouristicPlace = 1
}

// Define the structure with the name of the poperties for the JSON string
enum CodingKeys: String, CodingKey{
    case id
    case description
    case name
    case type
    case latitude
    case longitude
}

class Place: Codable {
        
    var id:String = ""
    var type:PlacesTypes = .GenericPlace
    var name:String = ""
    var description:String = ""
    var location:CLLocationCoordinate2D!
    var image:Data? = nil

    init() {
        self.id = UUID().uuidString
    }
    
    init(name:String, description:String, image_in:Data?) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_in
    }
    
    init(type:PlacesTypes, name:String, description:String, image_in:Data?) {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.description = description
        self.image = image_in
        self.location = ManagerLocation.GetLocation()
    }
    
    // Methods to work with JSON serializaion/deserialization
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // encode all Places's properties
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(location.latitude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
    }
    
    
    func decode(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(PlacesTypes.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        try decode(from: decoder)
    }
 
}
