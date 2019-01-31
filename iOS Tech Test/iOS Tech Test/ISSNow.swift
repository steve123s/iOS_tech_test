//
//  ISSNow.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 18/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import ObjectMapper
import CoreLocation

class ISSResponse: Mappable {
    
    var message: String? = nil
    var timestamp: Double? = nil
    var position: ISSPosition? = nil
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        timestamp <- map["timestamp"]
        position <- map["iss_position"]
    }
}

class ISSPosition: Mappable {

    var latitude: String?
    var longitude: String?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitudeStr = latitude, let longitudeStr = longitude else { return nil }
        guard let lat = Double(latitudeStr), let lon = Double(longitudeStr) else { return nil }
        // Var was returning nil instead of a CLLocationCoordinate2D
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
