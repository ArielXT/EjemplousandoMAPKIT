//
//  LocationViewModel.swift
//  Navigation
//
//  Created by MAC21 on 22/06/22.
//

import Foundation
import CoreLocation
import MapKit

final class LocationViewModel: NSObject, ObservableObject{
    private struct DefaultRegion{
        static let latitude = -12.082060
        static let longitude = -77.035974
    }
    private struct Span{
        static let delta = 0.1
    }
    
    @Published var userHasLocation: Bool = false
    @Published var userLocation: MKCoordinateRegion = .init()
    private let locationManager: CLLocationManager = .init()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        userLocation = .init(center: .init(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude),
                             span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
    func checkUserAuthorization(){
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined, .restricted, .denied:
            userHasLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            userHasLocation = true
        @unknown default:
            print("Estado no soportado")
        }
    }
}


extension LocationViewModel: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        print("Locacion \(location)")
        userLocation = .init(center: location.coordinate, span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAuthorization()
    }
}
