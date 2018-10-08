//
//  Place.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

import MapKit

enum PlaceType {
    case GenericPlace
    case TouristicPlace
}

class Place {
    var Id:String = ""
    var PlaceType:PlaceType = .GenericPlace
    var Name:String = ""
    var Description:String = ""
    var Location:String = ""
    var Image:Data? = nil
    
    init() {
        self.Id = UUID().uuidString
    }
    
    init(name:String, description:String, image_in:Data?) {
        self.Id = UUID().uuidString
        self.Name = name
        self.Description = description
        self.Image = image_in
    }
    
    init(type:PlaceType, name:String, description:String, image_in:Data?) {
        self.Id = UUID().uuidString
        self.Name = name
        self.Description = description
        self.Image = image_in
    }
}
