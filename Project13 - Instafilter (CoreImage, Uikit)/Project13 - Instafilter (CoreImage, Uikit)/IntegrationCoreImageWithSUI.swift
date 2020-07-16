//
//  IntegrationCoreImageWithSUI.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 15.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct IntegrationCoreImageWithSUI: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        
        // Фильтр старости
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
        
        // Фильтр сделать пиксельным
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 16
        
        //не может обработать
//        let currentFilter = CIFilter.crystallize()
//        //Для старых версий
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        //currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct IntegrationCoreImageWithSUI_Previews: PreviewProvider {
    static var previews: some View {
        IntegrationCoreImageWithSUI()
    }
}
