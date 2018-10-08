//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

class ManagerPlaces {
    var places = [Place]()
    
    func Append(_ value:Place){
        // Adds a new Place to the array
        places.append(value)
    }
    
    func GetCount() -> Int{
        //returns the number of Places in the array
        return places.count
    }
    
    func GetItemAt(position:Int) -> Place? {
        // Returns the Place at the specific position
        if places.count > 0{
            return places[position]
        }
        else{
            return nil
        }
    }
    
    func GetItemById(id:String) -> Place? {
        // Get a Place by its identifier
        if places.count > 0{
            let place = places.filter({$0.Id == id})
            if place.count > 0 {
                return place[0]
            }
            else{
                return nil
            }
        }
        else{
            return nil
        }
    }
    
    func Remove(_ value:Place){
        if places.count > 0 {
            let temp = places.filter({$0.Id != value.Id})
            places = temp
        }

    }
    
    //******************************************
    // Singleton - Unique instance for all App
    
    private static var sharedManagerPlaces: ManagerPlaces = {
        
        var singletonManager:ManagerPlaces
        
        singletonManager = ManagerPlaces()
        
        return singletonManager
    }()
    
    
    class func shared() -> ManagerPlaces {
        return sharedManagerPlaces
    }
    
    // ****************************************
    
}
