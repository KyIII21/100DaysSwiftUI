//
//  PhotoDescription.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 12.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct PhotoDescription: View {
    let photo: PhotoName
    let image: Image?
    var body: some View {
        VStack{
            Text(photo.name)
            Text(photo.url)
            image?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400, alignment: .top)
                
        }
        
    }
}

//struct PhotoDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDescription(photo: PhotoName(name: "TestName", url: "test"))
//    }
//}
