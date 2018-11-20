//
//  SecondViewController.swift
//  MyPlaces
//
//  Created by user145617 on 9/21/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, ManagerPlacesObserver {
    func onPlacesChange() {
        addMarkers()
    }
    
    let m_provider:ManagerPlaces = ManagerPlaces.shared()
    
    @IBOutlet weak var m_map: MKMapView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_map.delegate = self
        
        // Add the view to the observer in order the list to be updated each time a place is moified
        let manager = ManagerPlaces.shared()
        manager.addObserver(object: self)
        
        addMarkers()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func removeMarkers()  {
        // Removes all markers from screen
        let lista = self.m_map.annotations.filter {!($0 is MKUserLocation)}
        self.m_map.removeAnnotations(lista)
    }
    
    func addMarkers(){
        // Add markets to the screen
        let provider:ManagerPlaces = ManagerPlaces.shared()
        for i in 0..<provider.GetCount(){
            let p = provider.GetItemAt(position: i)
            
            let title:String = p!.name
            let subtitle:String = p!.description
            let id:String = p!.id
            let lat:Double = p!.location.latitude
            let lon:Double = p!.location.longitude
            
            let annotation:MKMyPointAnnotation = MKMyPointAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat,longitude: lon), title: title, subtitle: subtitle, placeId: id)
            
            self.m_map.addAnnotation(annotation)
            
        }
    }
    
    // Methods needed for MKMapviewDelegate delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKMyPointAnnotation{
            let identifier = "CustomPinAnnotationView"
            var pinView:MKPinAnnotationView
            if let dequeuedView = self.m_map.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                pinView = dequeuedView
            }
            else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView.canShowCallout = true
                pinView.calloutOffset = CGPoint(x: -5, y: 5)
                pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                pinView.setSelected(true, animated: true)
            }
            return pinView
        }
        return nil
    }
    
    // Detect when user presses onthe button associated to the marker
    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control:UIControl){
        let annotation:MKMyPointAnnotation = annotationView.annotation as! MKMyPointAnnotation
        
        //show DetailControlle for selected pin (Place)
        let place = m_provider.GetItemById(id: annotation.placeId)
        
        let dc:DetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailController
        dc.place = place   // Cargamos en el Place del DC el place seleccionado
        present(dc, animated: true, completion: nil)
        
    }
}

