//
//  positionModel.swift
//  iOS Tech Test
//
//  Created by Daniel Esteban Salinas Suárez on 2/3/19.
//  Copyright © 2019 Urbvan Trantist. All rights reserved.
//

import Foundation
import CoreLocation

struct PositionModel {
    let position: CLLocationCoordinate2D
    var timeObtained: String
    
    init(position: CLLocationCoordinate2D) {
        self.position = position
        self.timeObtained = ""
        self.timeObtained = obtainTime()
    }
    
    private func obtainTime() -> String {
        // Get current date and time
        let currentDateTime = Date()
        // Initialize date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        return formatter.string(from: currentDateTime)
    }
    
}
