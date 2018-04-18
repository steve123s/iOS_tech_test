//
//  ViewController.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 16/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: ViewModel!
    var issAnnotation: ISSAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.getISSPosition { (response) in
            
            guard let coordinate = response?.position?.coordinate else { return }
            
            if self.issAnnotation == nil {
                self.issAnnotation = ISSAnnotation(coordinate: coordinate, title: "ISS", subtitle: "Current Location")
                self.mapView.addAnnotation(self.issAnnotation!)
            } else {
                self.issAnnotation?.coordinate = coordinate
            }
            
        }
        
    }


}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is ISSAnnotation {
            return ISSAnnotationView(annotation: annotation, reuseIdentifier: "ISS")
        }
        return nil
    }
    
}
