//
//  LocationViewController.swift
//  On The Map
//
//  Created by Norah Almaneea on 31/01/2021.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var acivityIndicator: UIActivityIndicatorView!
    var placeMark: CLPlacemark?
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func setUI(geocoding: Bool) {
        if geocoding {
            acivityIndicator.startAnimating()
        } else {
            acivityIndicator.stopAnimating()
        }
        
        locationTextField.isEnabled = !geocoding
        linkTextField.isEnabled = !geocoding
    }
    
    func getErrorMessageForGeocodinFailure(_ error: Error?) -> String {
        if let clError = error as? CLError {
            switch clError.code {
            case .geocodeFoundNoResult:
                return "Location Not Found."
            default:
                return clError.localizedDescription
            }
        } else {
            return error?.localizedDescription ?? ""
        }
    }
    
    func showGeocodingFailure(message: String) {
        let alertVC = UIAlertController(title: "Find Location Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertVC, animated: true)
    }
    
    func handleForwardGeocode(placeMarks: [CLPlacemark]?, error: Error?) {
        setUI(geocoding: false)
        if let placeMark = placeMarks?[0] {
            self.placeMark = placeMark
            self.performSegue(withIdentifier: "finishAddLocation", sender: nil)
        } else {
            showGeocodingFailure(message: getErrorMessageForGeocodinFailure(error))
        }
    }
    
    @IBAction func findLocationTapped(_ sender: Any) {
        if linkTextField.text?.isEmpty == true {
            showGeocodingFailure(message: "The Link Is Empty")
        }
        
        setUI(geocoding: true)
        
        CLGeocoder().geocodeAddressString(locationTextField.text!) { (placeMarks, error) in
            DispatchQueue.main.async {
                self.handleForwardGeocode(placeMarks: placeMarks, error: error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(geocoding: false)
        // Do any additional setup after loading the view.
    }
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeMark = placeMark {
            let  LocationAddedViewController = segue.destination as! LocationAddedViewController
            LocationAddedViewController.placeMark = placeMark
            LocationAddedViewController.mapString = placeMark.name!
            LocationAddedViewController.url = URL(string: self.linkTextField.text!)
        }
    }

}
