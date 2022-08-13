//
//  ViewController.swift
//  AulaMapKitCEFETTarde
//
//  Created by Student on 10/08/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var meuMapa: MKMapView!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meuMapa.setUserTrackingMode(.follow, animated: true)
        meuMapa.showsUserLocation = true
        setupLocationManager()
        addGesture()
        
    }
    
    //Função 01 - Configurar as propriedades do mapa
    func setupLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //Func 02 - Configurando a ultima localizaçao no mapa
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            if let location = locations.last{
                
                userLocation = location
                print("A localização do usuário é: \(userLocation.coordinate)")
            }
        }
    }

    //Funcao 03 - Criando anotaçoes no mapa
    @objc func addAnnotationToMap(gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: meuMapa)
        
        let newCoordinate:CLLocationCoordinate2D = meuMapa.convert(touchPoint, toCoordinateFrom: meuMapa)
        
        let newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "João Marcello"
        newAnnotation.subtitle = String(describing: "Latitude \(newCoordinate.latitude) / Longitude \(newCoordinate.longitude)")
        
        meuMapa.addAnnotation(newAnnotation)
    }
    
    //Funcao 04 - Configurar o gesto no mapa
    func addGesture(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap(gestureRecognizer:)))
        
        longPress.minimumPressDuration = 0.8
        
        meuMapa.addGestureRecognizer(longPress)
    }

}

