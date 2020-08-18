//
//  LocationFetcher.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 17.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
