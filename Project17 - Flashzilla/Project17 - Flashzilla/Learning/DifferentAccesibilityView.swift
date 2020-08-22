//
//  DifferentAccesibilityView.swift
//  Project17 - Flashzilla
//
//  Created by Дмитрий on 22.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI



struct DifferentAccesibilityView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }

                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Text("withOptionalAnimation!")
                .scaleEffect(scale)
//                .onTapGesture {
//                    if self.reduceMotion {
//                        self.scale *= 1.5
//                    } else {
//                        withAnimation {
//                            self.scale *= 1.5
//                        }
//                    }
//                }
                .onTapGesture {
                    self.withOptionalAnimation {
                        self.scale *= 1.5
                    }
                }
            
            Text("reduceTransparency!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
        }
    }
}

struct DifferentAccesibilityView_Previews: PreviewProvider {
    static var previews: some View {
        DifferentAccesibilityView()
    }
}
