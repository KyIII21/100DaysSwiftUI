//
//  BindingLearn.swift
//  Project13 - Instafilter (CoreImage, Uikit)
//
//  Created by Дмитрий on 14.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct BindingLearn: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct BindingLearn_Previews: PreviewProvider {
    static var previews: some View {
        BindingLearn()
    }
}
