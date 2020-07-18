//
//  SaveImageInLibraryView.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 18.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct SaveImageInLibraryView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        //Сохранение фото в библиотеку
        //UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

struct SaveImageInLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        SaveImageInLibraryView()
    }
}
