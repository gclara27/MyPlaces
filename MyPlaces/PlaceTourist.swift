//
//  PlaceTourist.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

class PlaceTourist: Place {
    var DiscountTourist:String = ""
    
    override init() {
        super.init()
        PlaceType = .TouristicPlace
    }
    
    init(name:String, description:String, discountTourist:String, image_in:Data?) {
        super.init(type:.TouristicPlace, name:name, description:description, image_in:image_in!)
        self.DiscountTourist = discountTourist
    }
}
