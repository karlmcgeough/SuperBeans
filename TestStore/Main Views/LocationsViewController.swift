//
//  LocationsViewController.swift
//  TestStore
//
//  Created by Karl McGeough on 09/10/2019.
//  Copyright © 2019 Karl McGeough. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class CoffeeStoreAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
  
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}

class LocationsViewController: UIViewController {
    let locationManger = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

         let initialLocation = CLLocation(latitude: 54.5967, longitude: -5.9301)
               
            
                  centerMapOnLocation(location: initialLocation)
                
        locationManger.requestWhenInUseAuthorization()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.distanceFilter = kCLDistanceFilterNone
        locationManger.startUpdatingLocation()
                
                mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
                
                let storeOneCoordinate = CLLocationCoordinate2D(latitude: 54.6023, longitude: -5.9291)
                let storeOneAnnotation = CoffeeStoreAnnotation(coordinate: storeOneCoordinate, title: "SuperBeans Cathedral", subtitle: "Modern, bright, cool coffee store located in the heart of the cathedral quarter. Open 7-22 Mon-Sat, 10-6 Sun")
                
                let storeTwoCoordinate = CLLocationCoordinate2D(latitude: 54.5884, longitude: -5.9330)
                let storeTwoAnnotation = CoffeeStoreAnnotation(coordinate: storeTwoCoordinate, title: "SuperBeans Botantic", subtitle: "Modern, bright, cool coffee store located in the heart of Botanic Belfast. Open 7-23 Mon-Sat, 10-6 Sun")
                
                let storeThreeCoordinate = CLLocationCoordinate2D(latitude: 54.5967, longitude: -5.9301)
                let storeThreeAnnotation = CoffeeStoreAnnotation(coordinate: storeThreeCoordinate, title: "SuperBeans City Center", subtitle: "Modern, bright, cool coffee store located in the heart of Belfast located right beside Belfast City Hall. Open 6-18 Mon-Sat, 10-18 Sun")
                
                mapView.addAnnotation(storeOneAnnotation)
                mapView.addAnnotation(storeTwoAnnotation)
                mapView.addAnnotation(storeThreeAnnotation)
                mapView.showsUserLocation = true
       
       
        
            }

        let regionRadius: CLLocationDistance = 5000
            
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        }

        extension LocationsViewController: MKMapViewDelegate{
            func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)-> MKAnnotationView?{
                if let coffeeStoreAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView{
                    
                    coffeeStoreAnnotationView.animatesWhenAdded = true
                    coffeeStoreAnnotationView.titleVisibility = .adaptive
                    coffeeStoreAnnotationView.titleVisibility = .adaptive
                    
                    return coffeeStoreAnnotationView
                }
                  return nil
              }
          }
