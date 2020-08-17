//
//  ContentView.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 12.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct PhotoName: Codable{
    var name: String
    var url: String
}
struct PhNames: Codable{
    var items: [PhotoName]{
        didSet {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(items) {
               UserDefaults.standard.set(encoded, forKey: "Items")
           }
       }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
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
    
    var addButton: some View{
        Button(action:{self.showingImagePicker.toggle()}){
            Text("Add Photo")
                .sheet(isPresented: $showingImagePicker, onDismiss: showNaming) {
                    ImagePicker(image: self.$inputImage)
                }
                
        }
    }
    
    func showNaming(){
        if self.inputImage != nil{
            self.showingImageNaming.toggle()
        }
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
        
        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        let urlId = UUID().description

        imageSaver.writeToDevice(image: processedImage, photoUrl: urlId)
        
        let photo = PhotoName(name: self.namePhoto, url: urlId)
        
        myPhotoNames.items.append(photo)
        
        self.namePhoto = ""
        self.inputImage = nil
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets{
            let url = myPhotoNames.items[offset].url
            ImageSaver().deleteFile(url: url)
        }
        
        myPhotoNames.items.remove(atOffsets: offsets)
    }
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(myPhotoNames.items, id: \.name){ photo in
                    NavigationLink(destination: PhotoDescription(photo: photo, image: ImageSaver().loadImage(url: photo.url))){
                        HStack{
                            ImageSaver().loadImage(url: photo.url)?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 70)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            Text(photo.name)
                        }
                        .sheet(isPresented: self.$showingImageNaming, onDismiss: self.checktoSaveImage) {
                            NamingView(name: self.$namePhoto, image: self.inputImage!)
                        }
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Call the Photo")
            .navigationBarItems(trailing: addButton)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
