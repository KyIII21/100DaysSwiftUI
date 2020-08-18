//
//  MapView.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 18.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let location: CLLocationCoordinate2D
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Add the pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // TODO: Finish the map
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
}
