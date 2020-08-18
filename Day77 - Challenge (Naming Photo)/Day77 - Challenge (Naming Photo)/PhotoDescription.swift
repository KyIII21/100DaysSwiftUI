//
//  PhotoDescription.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 12.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PhotoDescription: View {
    let photo: PhotoName
    var body: some View {
        VStack{
            Text(photo.name)
            Text(photo.url)
            FileImageManager().loadImage(url: photo.url)?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400, alignment: .top)
            MapView(location: CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude))
                
        }
        
    }
}

//struct PhotoDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDescription(photo: PhotoName(name: "TestName", url: "test"))
//    }
//}
