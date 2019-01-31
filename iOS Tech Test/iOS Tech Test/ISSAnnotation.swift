//
//  ISSAnnotation.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 18/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import MapKit

class ISSAnnotation: NSObject, MKAnnotation {
    
    dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}

class ISSAnnotationView: MKAnnotationView {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        // Make annotationView display default bubble with title and description. Previously was ignoring them.
        self.canShowCallout = true
        let pinImageView = UIImageView(frame: CGRect(x: -15, y: -15, width: 30, height: 30))
        pinImageView.image = UIImage(named: "space-station")
        pinImageView.contentMode = .scaleAspectFit
        let pinTitleLabel = UILabel(frame: CGRect(x: -15, y: 15, width: 30, height: 20))
        pinTitleLabel.text = annotation?.title ?? ""
        pinTitleLabel.textAlignment = .center
        
        addSubview(pinImageView)
        addSubview(pinTitleLabel)

    }
    
}
