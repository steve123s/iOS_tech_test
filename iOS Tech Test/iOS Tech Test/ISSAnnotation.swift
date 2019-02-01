//
//  ISSAnnotation.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 18/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import MapKit

/*
 ISSAnnotation se va a encargar de crear las anotaciones que veremos en el mapa.
 Cuenta con un título, subtítulo y coordenada.
 Es importante ver que la variable coordinate tiene el modificador "dynamic".
 dynamic hace referencia al dynamic dispatch de Objective-C, por lo tanto implícitamente también es un @objc y se utiliza porque la coordenada estará cambiando en tiempo de ejecución y para estos casos funciona mejor el dynamic dispatch de Objective-C que el static de Swift.
 
 Como queremos vistas personalizadas vamos a necesitar otra clase para crearlas. ISSAnnotationView se encargará de ello.
 En esta clase creamos una vista con una imagen y un título como subvistas. Y se creará una cuando el delegado de MKMapView llame a la función de annotation en nuestro ViewController.
 */
class ISSAnnotation: NSObject, MKAnnotation {
    
    // coordinat
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
