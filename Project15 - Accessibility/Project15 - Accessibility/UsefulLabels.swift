//
//  UsefulLabels.swift
//  Project15 - Accessibility
//
//  Created by Дмитрий on 30.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct UsefulLabels: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                self.selectedPicture = Int.random(in: 0...3)
            }
            //Добавляем название для озвучки
            .accessibility(label: Text(labels[selectedPicture]))
            //Добавляем информацию о элементе
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
    }
}

struct UsefulLabels_Previews: PreviewProvider {
    static var previews: some View {
        UsefulLabels()
    }
}
