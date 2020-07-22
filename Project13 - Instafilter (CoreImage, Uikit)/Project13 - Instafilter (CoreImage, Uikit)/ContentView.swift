//
//  ContentView.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 14.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var showingEmptyImage = false
    @State private var filterName = "Sepia Tone"
    @State private var showingRadius = false
    @State private var showingScale = false
    @State private var showingIntensity = true
    @State private var filterRadius = 10.0
    @State private var filterScale = 5.0
    let context = CIContext()
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            showingIntensity = true
        }else{
            showingIntensity = false
        }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
            showingRadius = true
        }else{
            showingRadius = false
        }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
            showingScale = true
        }else{
            showingScale = false
        }

        guard let outputImage = currentFilter.outputImage else { return }

//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//            let uiImage = UIImage(cgImage: cgimg)
//            image = Image(uiImage: uiImage)
//        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }

                if(showingIntensity){
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }.padding(.vertical)
                }
                if(showingRadius){
                    HStack {
                        Text("Radius")
                        Slider(value: radius, in: 0...50)
                    }.padding(.vertical)
                }
                if(showingScale){
                    HStack {
                        Text("Scale")
                        Slider(value: scale, in: 0...100)
                    }.padding(.vertical)
                }

                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet.toggle()
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showingEmptyImage = true
                            return
                        }

//                        let imageSaver = ImageSaver()
//                        imageSaver.writeToPhotoAlbum(image: processedImage)
                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: self.$showingEmptyImage){
                        Alert(title: Text("Error"), message: Text("Choice a Image"), dismissButton: .default(Text("Ok")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter (\(self.filterName))")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.filterName = "Crystallize"
                        self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) {
                        self.filterName = "Edges"
                        self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) {
                        self.filterName = "Gaussian Blur"
                        self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) {
                        self.filterName = "Pixellate"
                        self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) {
                        self.filterName = "Sepia Tone"
                        self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) {
                        self.filterName = "Unsharp Mask"
                        self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) {
                        self.filterName = "Vignette"
                        self.setFilter(CIFilter.vignette()) },
                    .default(Text("Circular Screen")){
                        self.filterName = "Circular Screen"
                        self.setFilter(CIFilter.circularScreen())
                        },
                    .cancel()
                ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
