//
//  ContentView.swift
//  Project9 - Drawing (CGAffineTransform, ImagePaint, drawingGroup(),  animatableData, AnimatablePair)
//
//  Created by Дмитрий on 30.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Text("Hello World")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            
            Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 50)
            .frame(width: 300, height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
