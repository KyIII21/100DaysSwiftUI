//
//  SaveImageInLibrary.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 17.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
