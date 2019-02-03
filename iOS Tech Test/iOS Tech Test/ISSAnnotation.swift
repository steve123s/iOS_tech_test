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
    var pulseLayers = [CAShapeLayer]()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        // Make annotationView display default bubble with title and description. Previously was ignoring them.
        self.canShowCallout = true
        // Space station imageView
        let pinImageView = UIImageView(frame: CGRect(x: -15, y: -15, width: 30, height: 30))
        pinImageView.image = UIImage(named: "space-station")
        pinImageView.contentMode = .scaleAspectFit
        // titleLabel view
        let pinTitleLabel = UILabel(frame: CGRect(x: -15, y: 15, width: 30, height: 20))
        pinTitleLabel.text = annotation?.title ?? ""
        pinTitleLabel.textAlignment = .center
        // Add animations to image before adding it as a subview
        createPulse(around: pinImageView)
        addSubview(pinImageView)
        addSubview(pinTitleLabel)
    }
    
    func createPulse(around image: UIImageView) {
        // Create 3 pulses
        let pulseQuantity = 3
        for _ in 0..<pulseQuantity {
            // Create a full circle path (from 0 to 2pi radians)
            let circularPath =
                UIBezierPath(arcCenter: .zero,
                             radius: image.frame.size.height*2,
                             startAngle: 0,
                             endAngle: 2 * .pi,
                             clockwise: true)
            // Create a CALayer from our path because we want to animate
            let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 2.0
            // We only want to see the circle's stroke
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.strokeColor = UIColor.black.cgColor
            // Place the CALayer at the center of our image
            pulseLayer.position = CGPoint(
                        x: image.frame.size.width/2.0,
                        y: image.frame.size.width/2.0)
            // Add CALayer to image and to pulseLayers array
            image.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        // Animate every pulse created with difference of 0.2 between them
        for (index,_) in pulseLayers.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2*Double(index+1)) {
                self.animatePulseAt(index)
            }
        }
    }
    
    func animatePulseAt(_ index: Int) {
        let duration = 3.0
        // Pulse scale up animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        // Values for interpolation
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 1.0
        // Add an easeOut effect for better looks
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        // Repeat forever
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        // Pulse fade out animation
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        // Values for interpolation
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        // Add an easeOut effect for better looks
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        // Repeat forever
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
    

}
