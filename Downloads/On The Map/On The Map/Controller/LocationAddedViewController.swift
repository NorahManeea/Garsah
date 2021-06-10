//
//  LocationAddedViewController.swift
//  On The Map
//
//  Created by Norah Almaneea on 31/01/2021.
//

import UIKit
import MapKit

class LocationAddedViewController: UIViewController, MKMapViewDelegate {
    var mapString: String!
    var url: URL!
    var placeMark: CLPlacemark!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeMark.location!.coordinate
        let regionRadius: CLLocationDistance = 10000
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        DispatchQueue.main.async {
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pinView.canShowCallout = true
            pinView.pinTintColor = .red
            return pinView
        }
        
        
    }
    @IBAction func finished(_ sender: Any){
        let latitude = placeMark.location!.coordinate.latitude
        let longitude = placeMark.location!.coordinate.longitude
        
        let newLocation = PostLocationRequest(firstName: UdacityClient.Auth.firstName, lastName: UdacityClient.Auth.lastName, latitude: latitude, longitude: longitude, mapString: mapString,mediaURL: url.absoluteString, uniqueKey: UdacityClient.Auth.accountId)
        
        UdacityClient.postLocation(location: newLocation) { (studentLocation, error) in
            if let studentLocation = studentLocation {
                OnTheMapModel.studentLocations.append(studentLocation)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                let errorMessage = error?.localizedDescription ?? "Unknown Error"
                let alertVC = UIAlertController(title: "Find Location Failed", message: errorMessage, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alertVC, animated: true)
            }
        }
        
    }
    
}

