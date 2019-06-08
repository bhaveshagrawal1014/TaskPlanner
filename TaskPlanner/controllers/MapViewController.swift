//
//  MapViewController.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    private var selectedPoint: MKPointAnnotation?
    
    var currentAddress: Address?
    
    let newyorkLocation = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
    
    lazy var locationManager = CLLocationManager()
    lazy var service = GeocodingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.isEnabled = false
        mapView.userLocation.title = "I'm here"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    @IBAction func myLocationTap(_ sender: Any) {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            
            let alert = UIAlertController(title: "Geolocation is not available", message: "To determine the location, turn on the permission of geolocation in the settings", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Open settings", style: .default, handler: openSettingsHandler)
            alert.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openSettingsHandler(action: UIAlertAction) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let centerCoordinate = newyorkLocation
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        if let address = currentAddress {
            
            selectedPoint = MKPointAnnotation()
            mapView.addAnnotation(selectedPoint!)
            selectedPoint!.coordinate = CLLocationCoordinate2D(latitude: address.lat, longitude: address.lon)
            addressLabel.text = address.formattedAddress
            
            chooseButton.isEnabled = address.formattedAddress != nil
        }
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mapTap(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        let tapPoint = sender.location(in: mapView)
        let tapCoordintate = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        
        if selectedPoint == nil {
            selectedPoint = MKPointAnnotation()
            mapView.addAnnotation(selectedPoint!)
        }
        selectedPoint?.coordinate = tapCoordintate
        
        requestAddress(for: tapCoordintate)
    }
    
    func requestAddress(for location: CLLocationCoordinate2D) {
        service.getAddress(lat: location.latitude,
                           lon: location.longitude,
                           completion: getAddressHandler)
    }
    
    func getAddressHandler(result: ServiceResult<GeocodingResult>) {
        switch result {
        case .failure(let error):
            print(error)
            
            let alert = UIAlertController(title: "Error", message: "Failed to get address. The server is not responding or the Internet is unavailable.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        case .success(let payload):
            if payload.status == "ZERO_RESULTS" {
                self.addressLabel.text = "Nothing found"
                chooseButton.isEnabled = false
            } else {
                addressLabel.text = payload.results[0].formattedAddress
                chooseButton.isEnabled = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TaskViewController {
            currentAddress = Address(context: CoreDataStack.shared.viewContent)
            currentAddress!.lat = selectedPoint!.coordinate.latitude
            currentAddress!.lon = selectedPoint!.coordinate.longitude
            currentAddress!.formattedAddress = addressLabel.text
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else { return }
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        if selectedPoint == nil {
            selectedPoint = MKPointAnnotation()
            mapView.addAnnotation(selectedPoint!)
        }
        selectedPoint?.coordinate = location
        
        requestAddress(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }
    
}
