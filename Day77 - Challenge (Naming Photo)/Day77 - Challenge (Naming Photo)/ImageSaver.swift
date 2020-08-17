//
//  ImageSaver.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 12.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func writeToDevice(image: UIImage, photoUrl: String) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(photoUrl)
            try? jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
    }
    
    func loadImage(url: String) -> Image?{
        let fileURL = getDocumentsDirectory().appendingPathComponent(url)
        do {
            let data = try Data(contentsOf: fileURL)
            if let uiImage = UIImage(data: data){
                return Image(uiImage: uiImage)
            }
        } catch {
            print("Not able to load image")
        }
        return nil
    }
    
    func deleteFile(url: String){
        let fileURL = getDocumentsDirectory().appendingPathComponent(url)
        do{
            try FileManager.default.removeItem(at: fileURL)
            print("File Removed: \(url)")
        } catch {
            print("Not able to delete image: \(url)")
        }
        
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
