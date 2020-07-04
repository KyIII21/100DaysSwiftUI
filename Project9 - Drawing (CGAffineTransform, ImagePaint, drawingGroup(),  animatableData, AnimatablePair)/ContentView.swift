//
//  ContentView.swift
//  Project9 - Drawing (CGAffineTransform, ImagePaint, drawingGroup(),  animatableData, AnimatablePair)
//
//  Created by Дмитрий on 30.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    var thinkLine: Int
    var animatableData: Int {
        get { thinkLine }
        set { self.thinkLine = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arrLineCoordStart = rect.midX - CGFloat(self.thinkLine)/2
        let arrLineY = rect.maxY / 3
        //Drawing Triangle
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.minX, y: arrLineY))
        path.addLine(to: CGPoint(x: arrLineCoordStart, y: arrLineY))
        path.addLine(to: CGPoint(x: arrLineCoordStart, y: rect.maxY))
        path.addLine(to: CGPoint(x: arrLineCoordStart + CGFloat(thinkLine), y: rect.maxY))
        path.addLine(to: CGPoint(x: arrLineCoordStart + CGFloat(thinkLine), y: arrLineY))
        path.addLine(to: CGPoint(x: rect.maxX, y: arrLineY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var countLine: Int
    var amount: Double
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.countLine) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
    var body: some View {
        ZStack{
            ForEach (0..<countLine) { number in
                Rectangle()
                    .inset(by: CGFloat(number))
                    //.strokeBorder(self.color(for: number, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                    self.color(for: number, brightness: 1),
                    self.color(for: number, brightness: 0.7)
                ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
            
        }
        .drawingGroup()
    }
}

struct ContentView: View {
    @State private var thinkLine: CGFloat = 50
    @State private var numberLine: CGFloat = 100
    @State private var amount: CGFloat = 0.5

    var body: some View {
        VStack(spacing: 0) {
            Arrow(thinkLine: Int(self.thinkLine))
                .stroke(Color.black, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 150, height: 270)
                .padding()
            Slider(value: $thinkLine, in: 1...100)
                .padding()
            
            Spacer()
            
            ColorCyclingRectangle(countLine: Int(numberLine), amount: Double(amount))
                .frame(width: 300, height: 200)
                .padding()
            Text("Count Line:")
            Slider(value: $numberLine, in: 50...100)
                .padding()
            Text("Amount:")
            Slider(value: $amount)
                .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
