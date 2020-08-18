//
//  ContentView.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 12.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PhotoName: Codable{
    var name: String
    var url: String
    var latitude: Double
    var longitude: Double
}
struct PhNames: Codable{
    var items: [PhotoName]{
        didSet {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(items) {
               UserDefaults.standard.set(encoded, forKey: "NewItems")
           }
       }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "NewItems"){
            let decoder = JSONDecoder()
            if let decodeItem = try? decoder.decode([PhotoName].self, from: items){
                self.items = decodeItem
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @State var myPhotoNames = PhNames()
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingImageNaming = false
    let context = CIContext()
    @State private var namePhoto = ""
    
    let locationFetcher = LocationFetcher()
    @State private var location = CLLocationCoordinate2D()
    
    @State private var showingAlertLocation = false
    
    var addButton: some View{
        Button(action: showPicker){
            Text("Add Photo")
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: showNaming) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func getLocation(){
        self.locationFetcher.start()
        if let location = self.locationFetcher.lastKnownLocation {
            self.location = location
            print("Your location is \(location)")
        } else {
            self.showingAlertLocation.toggle()
            print("Your location is unknown")
        }
    }
    
    func showNaming(){
        if self.inputImage != nil{
            self.showingImageNaming.toggle()
        }
    }
    
    func showPicker(){
        self.showingImagePicker.toggle()
    }
    
    func checktoSaveImage(){
        if self.namePhoto != ""{
            self.saveImage()
        }
    }

    func saveImage(){
        guard let processedImage = self.inputImage else {
            return
        }
        
        let fileManager = FileImageManager()

        fileManager.successHandler = {
            print("Success!")
        }

        fileManager.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        let urlId = UUID().description

        fileManager.writeToDevice(image: processedImage, photoUrl: urlId)
        
        let photo = PhotoName(name: self.namePhoto, url: urlId, latitude: location.latitude, longitude: location.longitude)
        
        myPhotoNames.items.append(photo)
        
        self.namePhoto = ""
        self.inputImage = nil
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets{
            let url = myPhotoNames.items[offset].url
            FileImageManager().deleteFile(url: url)
        }
        
        myPhotoNames.items.remove(atOffsets: offsets)
    }
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(myPhotoNames.items, id: \.name){ photo in
                    NavigationLink(destination: PhotoDescription(photo: photo)){
                        HStack{
                            FileImageManager().loadImage(url: photo.url)?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 70)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            Text(photo.name)
                        }
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .onAppear(perform: self.getLocation)
            .alert(isPresented: self.$showingAlertLocation){
                Alert(title: Text("Serch Your Location is Error"), message: Text("We can try get your location."), primaryButton: .default(Text("Try"), action: self.getLocation), secondaryButton: .default(Text("Not Need")))
            }
            .sheet(isPresented: self.$showingImageNaming, onDismiss: self.checktoSaveImage) {
                    NamingView(name: self.$namePhoto, image: self.inputImage!)
            }
            .navigationBarTitle("Call the Photo")
            .navigationBarItems(trailing: addButton)
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
