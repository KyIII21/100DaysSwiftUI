//
//  MapView.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 25.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: //UIViewRepresentableContext<MapView>) -> MKMapView {
        Context) -> MKMapView{
        let mapView = MKMapView()
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
