//
//  UseGesturesVIew.swift
//  Project17 - Flashzilla
//
//  Created by Дмитрий on 21.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct UseGesturesVIew: View {
//    @State private var currentAmount: CGFloat = 0
//    @State private var finalAmount: CGFloat = 1
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        VStack{
            Text("Double tapped!")
            .onTapGesture(count: 2) {
                print("Double tapped!")
            }
            
            Text("Long pressed!")
            .onLongPressGesture(minimumDuration: 2) {
                print("Long pressed!")
            }
            
            Text("Long pressed with progress!")
                .onLongPressGesture(minimumDuration: 3, pressing: { inProgress in
                print("In progress: \(inProgress)!")
            }) {
                print("Long pressed!")
            }
            
//            Text("Hello, MagnificationGesture!")
//               .scaleEffect(finalAmount + currentAmount)
//               .gesture(
//                   MagnificationGesture()
//                       .onChanged { amount in
//                           self.currentAmount = amount - 1
//                       }
//                       .onEnded { amount in
//                           self.finalAmount += self.currentAmount
//                           self.currentAmount = 0
//                       }
//               )
            Text("Hello, RotationGesture!")
                .rotationEffect(currentAmount + finalAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            self.currentAmount = angle
                        }
                        .onEnded { angle in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = .degrees(0)
                        }
                )
            
            VStack {
                Text("highPriorityGesture")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
            
        }
    }
}

struct UseGesturesVIew_Previews: PreviewProvider {
    static var previews: some View {
        //UseGesturesVIew()
        Gestures()
    }
}

struct Gestures: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}
