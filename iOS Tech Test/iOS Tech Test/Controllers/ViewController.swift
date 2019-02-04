//
//  ViewController.swift
//  iOS Tech Test
//
//  Created by Luis Armando Chávez Soto on 16/04/18.
//  Copyright © 2018 Urbvan Trantist. All rights reserved.
//

import UIKit
import MapKit

/*
 Clase ViewController, se ejecuta como controlador de vista del mapa (vista inicial).
 Tiene 2 outlets hacia la vista del mapa y la label del título.
 También cuenta con 2 variables que hacen referencia a ViewModel y ISSAnnotation
 En viewDidLoad asignamos como delegado de mapView a la misma clase para que utilize la extensión para crear las vistas custom para las annotations.
 Posteriormente inicializamos viewModel y utilizamos su método getISSPosition.
 Si se ejecuta con éxito nos devolverá una "respuesta" de tipo ISSResponse. Obtenemos y nos aseguramos que exista una coordenada a partir de su posición y si es el caso, si no hay ya una annotation, se inicializa una nueva ISSAnnotation y se añade a nuestra mapView. Si ya hay una annotation, simplemente actualiza su coordenada.
 La vunción func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? de la extensión se ejecuta en el momento en el que se va a mostrar nuestra annotation en el mapa. Si no se implementa, simplemente se mostrará un pin con estilo default.
 */
class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    // iOSTechTestLabel was asociated with non-existing var
    //@IBOutlet weak var iOSTechTestLabel: UILabel!
    var ISSPositions = [PositionModel]()
    var issAnnotation: ISSAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // mapView delegate was missing
        mapView.delegate = self
        // First data fetch
        fetchData()
        // Then schedules a timer to get position every 15 seconds with infinite repetition.
        _ = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(ViewController.fetchData), userInfo: nil, repeats: true)
        // Make Navigation Bar invisible
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func fetchData() {
        let viewModel = ViewModel()
        viewModel.getISSPosition { (response) in
            guard let coordinate = response?.position?.coordinate else { return }
            // Set annotation coordinate as the center of mapView only for the first annotation
            if self.ISSPositions.isEmpty {
                self.mapView.setCenter(coordinate, animated: true)
            }
            // Save new position to array
            self.ISSPositions.append(PositionModel(position: coordinate))
            if self.issAnnotation == nil {
                self.issAnnotation = ISSAnnotation(coordinate: coordinate, title: "ISS", subtitle: "Current Location")
                self.mapView.addAnnotation(self.issAnnotation!)
            } else {
                // Animate change to new coordinate
                UIView.animate(withDuration: 1, animations: {
                    self.issAnnotation?.coordinate = coordinate
                })
            }
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass updated ISSPositions to TableVC
        if segue.identifier == "ISSHistorySegue" {
            let navigationController = segue.destination as! UINavigationController
            let tvc = navigationController.viewControllers.first as! ISSHistoryTableViewController
            tvc.ISSPositions = ISSPositions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Start new pulse animations
        if let annotation = mapView.annotations.first as? ISSAnnotation {
            if let annotationView = mapView.view(for: annotation) as? ISSAnnotationView {
                annotationView.layer.removeAllAnimations()
                annotationView.pulseLayers.removeAll()
                annotationView.pinImageView.layer.sublayers?.removeAll()
                annotationView.createPulse(around: annotationView.pinImageView )
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
