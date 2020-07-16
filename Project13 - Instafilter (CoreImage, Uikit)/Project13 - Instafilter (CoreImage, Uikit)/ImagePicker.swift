//
//  ImagePicker.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 16.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
