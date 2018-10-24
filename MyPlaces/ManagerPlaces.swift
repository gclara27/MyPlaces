//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by user145617 on 9/25/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation



class ManagerPlaces: Codable {
    var places = [Place]()      //Contains all Places
    
    public var m_observers = Array<ManagerPlacesObserver>()  //Contains the list of observers
    
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
            let place = places.filter({$0.id == id})
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
            let temp = places.filter({$0.id != value.id})
            places = temp
        }

    }
    
    static func load() -> ManagerPlaces?{
        var result:ManagerPlaces? = nil
        let dataStr = FileSystem.Read()
        if (dataStr != ""){
            do{
                let decoder = JSONDecoder()
                let data:Data = Data(dataStr.utf8)
                result = try decoder.decode(ManagerPlaces.self, from: data)
            }
            catch{
                print("Error loading JSON file with stored places.")
                result = nil
            }
        }
        return result
    }
    
    //******************************************
    // Singleton - Unique instance for all App
    
    private static var sharedManagerPlaces: ManagerPlaces = {
        
        var singletonManager:ManagerPlaces?
        
        singletonManager = load()
        
        if(singletonManager == nil){
            singletonManager = ManagerPlaces()
        }
        
        return singletonManager!
    }()
    
    class func shared() -> ManagerPlaces {
        return sharedManagerPlaces
    }
    // ****************************************
    
    // Methods to work with the observers
    
    // Add an element to the list of obersvers
    public func addObserver(object: ManagerPlacesObserver){
        m_observers.append(object)
    }
    
    //Execute on each observer from the list the method onPlacesChange
    public func updateObservers(){
        for observer in m_observers{
            observer.onPlacesChange()
        }
        store()
    }
    
    // Methods to work with JSON serializaion/deserialization
    func getPathImage(p:Place)->String{
        // return the path to the stored image base on its Id.
        let r = FileSystem.GetPathImage(id: p.id)
        return r
    }
    
    //JSON serialization/deserialization
    enum CodingKeys: String, CodingKey {
        case places
    }
    
    enum PlacesTypeKey: CodingKey {
        case type
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(places, forKey: .places)
    }
    
    
    func store(){
        // saves the JSON structure to a file
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            
            for place in places{
                if (place.image != nil){
                    FileSystem.WriteData(id: place.id, image: place.image!)
                    place.image = nil
                }
            }
            
            FileSystem.Write(data: String(data: data, encoding: .utf8)!)
        }
        catch{
            print("Erro saving image to file")
        }
    }
    
    func decode(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        places = [Place]()
        
        var objectsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.places)
        var tmp_array = objectsArrayForType
        
        while(!objectsArrayForType.isAtEnd) {
            let object = try objectsArrayForType.nestedContainer(keyedBy: PlacesTypeKey.self)
            let type = try object.decode(PlacesTypes.self, forKey: PlacesTypeKey.type)
            
            switch type {
            case PlacesTypes.TouristicPlace:
                self.Append(try tmp_array.decode(PlaceTourist.self))
            default :
                self.Append(try tmp_array.decode(Place.self)) }
        }
    }
    
    
}

// Protocol ManagerPlacesObserver

protocol ManagerPlacesObserver {
    func onPlacesChange()
}
