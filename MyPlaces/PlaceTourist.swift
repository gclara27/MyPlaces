//
//  PlaceTourist.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation



class PlaceTourist: Place {
    enum CodingKeysTourist: String, CodingKey {
        case discountTourist
    }
    
    //Class properties
    var DiscountTourist:String = ""
    
    override init() {
        super.init()
        type = .TouristicPlace
    }
    
    init(name:String, description:String, discountTourist:String, image_in:Data) {
        super.init(type:.TouristicPlace, name:name, description:description, image_in:image_in)
        self.DiscountTourist = discountTourist
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        try decode(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeysTourist.self)
        
        try container.encode(DiscountTourist, forKey: .discountTourist)
        try super.encode(to: encoder)
    }
    
 
    override func decode(from decoder: Decoder) throws {
        try super.decode(from: decoder)
        
        let container = try decoder.container(keyedBy: CodingKeysTourist.self)
        DiscountTourist = try container.decode(String.self, forKey: .discountTourist)
    }
    

    
}
