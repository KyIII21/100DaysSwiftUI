//
//  AllowsHitTestingView.swift
//  Project17 - Flashzilla
//
//  Created by Дмитрий on 22.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct AllowsHitTestingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
                //.allowsHitTesting(false)
            
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }
}

struct AllowsHitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        AllowsHitTestingView()
    }
}
