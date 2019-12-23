//
//  ViewController.swift
//  Onde Estou
//
//  Created by César  Ferreira on 23/12/19.
//  Copyright © 2019 César  Ferreira. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
        
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let userLocation: CLLocation = locations.last!
        
        let latitude: CLLocationDegrees = (userLocation.coordinate.latitude)
        let longitude: CLLocationDegrees = (userLocation.coordinate.longitude)
        let speed = userLocation.speed
        
        latitudeLabel.text = String(latitude)
        longitudeLabel.text = String(longitude)
        velocityLabel.text = String(speed)
        
        let deltaLat: CLLocationDegrees = 0.01
        let deltaLog: CLLocationDegrees = 0.01
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let area: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: deltaLat, longitudeDelta: deltaLog)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: area)
        map.setRegion(region, animated: true)

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if ( status != .authorizedWhenInUse ) {
            
            let alertController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso a sua localização", preferredStyle: .alert)
            
            let actionConfig = UIAlertAction(title: "Abrir configurações", style: .default) { (UIAlertAction) in
                
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
                
            }
            let actionCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(actionConfig)
            alertController.addAction(actionCancel)
            
            present( alertController, animated: true, completion: nil )
            
        }
        
    }
    
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
}

