//
//  MKMyPointAnnotation.swift
//  MyPlaces
//
//  Created by user145617 on 11/3/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MKMyPointAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var placeId: String = ""
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, placeId:String ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.placeId = placeId
    }
}
