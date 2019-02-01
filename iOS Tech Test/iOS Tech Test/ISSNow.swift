//
//  ISSNow.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 18/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import ObjectMapper
import CoreLocation

/*
 ISSResponse es el objeto al que se va a mapear la respuesta de la API. Hereda de Mappable porque ObjectMapper va a hacer el mapeo automáticamente.
 Tiene 3 parámetros, de los cuales el último es un ISSPosition que se va a devolver una coordenada a partir de las coordenadas de latitud y longitud de la respuesta. ISSPsition también debe heredar de Mappable porque en ella se mapea la latitud y longitud desde la API. La función mapping es la que lo hace posible, en ella podemos ver que se pasan las llaves del JSON para obtener su valor.
 */
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
