//
//  UIMapViewController.swift
//  On The Map
//
//  Created by Norah Almaneea on 03/02/2021.
//

import UIKit
import MapKit

class UImapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        // Do any additional setup after loading the view.
        UdacityClient.getStudentLocations(completion: handleStudentLocationsResponse(studentLocations:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMap()
    }
    // MARK: - Refresh Button
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        UdacityClient.getStudentLocations(completion: handleStudentLocationsResponse(studentLocations:error:))
    }
    
    func updateMap() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        var pointAnnotations = [MKPointAnnotation]()
        
        for location in OnTheMapModel.studentLocations {
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            point.title = "\(location.firstName) \(location.lastName)"
            point.subtitle = location.mediaURL
            
            pointAnnotations.append(point)
        }
        
        self.mapView.addAnnotations(pointAnnotations)
    }

    func handleStudentLocationsResponse(studentLocations: [StudentLocation], error: Error?) {
        if let error = error {
            showDownloadStudentLocationsFailure(message: error.localizedDescription)
        } else {
            OnTheMapModel.studentLocations = studentLocations
            updateMap()
        }
    }
    
    func showDownloadStudentLocationsFailure(message: String) {
        let alertVC = UIAlertController(title: "Download Locations Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "Pin"
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pin!.canShowCallout = true
            pin!.pinTintColor = .red
            pin!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pin!.annotation = annotation
        }
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle!, let url = URL(string: toOpen) {
                UIApplication.shared.open(url)
            }
        }
    }
    // MARK: - Add Location Button
    @IBAction func addLocationButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addLocation", sender: nil)
    }
    // MARK: - Logout Button
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        UdacityClient.deleteSession { (success, error) in
            print("Logged out")
            self.dismiss(animated: true)
        }
    }
}

