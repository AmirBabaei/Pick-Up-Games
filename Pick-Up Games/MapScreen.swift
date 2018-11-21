//
//  MapScreen.swift
//  Pick-Up Games
//
//  Created by Amir Babaei on 11/5/18.
//  Copyright © 2018 Amir Babaei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol VCFinalDelegate {
  func finishPassing(dict: Dictionary<String, Any>)
}

class MapScreen: UIViewController {

  var delegate: VCFinalDelegate?

  @IBOutlet var MapView: MKMapView!
  var addy = String()
  var dict: Dictionary<String,Any> = Dictionary()
  var loc = String()
  //address text
  @IBOutlet var addressLabel: UILabel!
  @IBAction func doneButton(_ sender: Any) {
    //checkLocationServices()
    delegate?.finishPassing(dict: self.dict)
    //performSegue(withIdentifier: "mapSegue", sender: self)
    dismiss(animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let createEvent = segue.destination as! CreateEvent
    createEvent.addressString = addy
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the Navigation Bar
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  let locationManager = CLLocationManager()
  let regionInMeters: Double = 5000
  var previousLocation: CLLocation?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
  
  func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  
  func centerViewOnUserLocation() {
    if let location = locationManager.location?.coordinate {
      let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
      MapView.setRegion(region, animated: true)
    }
  }
  
  
  func checkLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
      setupLocationManager()
      checkLocationAuthorization()
    } else {
      // Show alert letting the user know they have to turn this on.
    }
  }
  
  
  func checkLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      startTackingUserLocation()
    case .denied:
      // Show alert instructing them how to turn on permissions
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      // Show an alert letting them know what's up
      break
    case .authorizedAlways:
      break
    }
  }
  
  func startTackingUserLocation() {
    MapView.showsUserLocation = true
    centerViewOnUserLocation()
    locationManager.startUpdatingLocation()
    previousLocation = getCenterLocation(for: MapView)
  }
  
  
  
  func getCenterLocation(for mapView: MKMapView) -> CLLocation {
    let latitude = mapView.centerCoordinate.latitude
    let longitude = mapView.centerCoordinate.longitude
    
    return CLLocation(latitude: latitude, longitude: longitude)
  }
}



extension MapScreen: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //needs work
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkLocationAuthorization()
  }
}



extension MapScreen: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    let center = getCenterLocation(for: mapView)
    let geoCoder = CLGeocoder()
    
    guard let previousLocation = self.previousLocation else { return }
    
    guard center.distance(from: previousLocation) > 50 else { return }
    self.previousLocation = center
    
    geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
      guard let self = self else { return }
      
      if let _ = error {
        //TODO: Show alert informing the user
        return
      }
      
      guard let placemark = placemarks?.first else {
        //TODO: Show alert informing the user
        return
      }
      
      let streetNumber = placemark.subThoroughfare ?? ""
      let streetName = placemark.thoroughfare ?? ""
      let cityName = placemark.locality ?? ""
      let locationName = placemark.name ?? ""
      
      DispatchQueue.main.async {
        print("streetNumber",streetNumber)
        print("sreetName",streetName)
        print("city",cityName)
        print("location",locationName)

        var str = "\(streetNumber) \(streetName)"
        
        if locationName == str {
          print("theyre equal ",str,locationName)
           self.addressLabel.text = " \(locationName) \n \(cityName)"
         
          var dict2:Dictionary<String,Any> = [
            "address": " \(streetNumber) \(streetName) \(cityName)",
            "locationName":"\(locationName)",
            "locLong": mapView.centerCoordinate.longitude,
            "locLat":mapView.centerCoordinate.latitude,
            "distance": previousLocation.distance(from: self.getCenterLocation(for: mapView))
          ]
          self.dict = dict2

            self.addy = " \(locationName), \(cityName)"

        }else {
          print("theyre not equal ",str,locationName)

           self.addressLabel.text = " \(locationName) \n \(streetNumber) \(streetName)\n \(cityName)"
          var dict2:Dictionary<String,Any> = [
            "address": "\(locationName)\(streetNumber) \(streetName) \(cityName)",
            "locationName":"\(locationName)",
            "locLong": mapView.centerCoordinate.longitude,
            "locLat":mapView.centerCoordinate.latitude,
            "distance": previousLocation.distance(from: self.getCenterLocation(for: mapView))

          ]
          self.dict = dict2
          self.addy = "\(locationName), \(cityName)"

        }
        self.loc = "\(locationName)"
      }
    }
  }
}
