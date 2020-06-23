//
//  ContentView.swift
//  Project2 (Gradients, Button, Image, Alert)
//
//  Created by Дмитрий on 18.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct OurImage: ViewModifier{
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
            .shadow(color: .black, radius: 2)
    }
}
extension View{
    func ourImageStyle() -> some View{
        self.modifier(OurImage())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var showingSpin: [Bool] = [false, false, false]
    @State private var showingOpacity: [Bool] = [false, false, false]
    @State private var showingWrong: [Bool] = [false, false, false]
    @State private var scoreTitle = ""
    @State private var scoreCorrect = 0
    @State private var scoreWrong = 0
    @State private var tapNumber = 0
    @State private var animationAmount: CGFloat = 1
    

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    HStack{
                        Text("Score:")
                            .foregroundColor(.white)
                        Text("\(self.scoreCorrect)")
                            .foregroundColor(.green)
                        Text("\(self.scoreWrong)")
                            .foregroundColor(.red)
                    }
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        if number == self.correctAnswer {
                            self.showingSpin[number].toggle()
                            for index in 0...2 {
                                if index != number{
                                    self.showingOpacity[index] = true
                                }
                            }
                        }
                        else{
                            self.showingWrong[number].toggle()
                            self.animationAmount = 1.5
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .rotation3DEffect(self.showingSpin[number] ? .degrees(360) : .zero, axis: (x: 0, y: 1, z: 0))
                            .opacity(self.showingOpacity[number] ? 0.5 : 1)
                            .animation(.default)
                            .ourImageStyle()
                            .overlay( self.showingWrong[number] ?
                                Capsule()
                                    .stroke(Color.red)
                                    .scaleEffect(self.animationAmount)
                                    .opacity(Double(2.5 - self.animationAmount))
                                    .animation(
                                        Animation.easeOut(duration: 1)
                                            .repeatForever(autoreverses: false)
                                    )
                                .onAppear{
                                    self.animationAmount = 1
                                }
                                : nil
                            )
                    }
                    .alert(isPresented: self.$showingScore){        Alert(title: Text(self.scoreTitle), message: self.textForAlert(), dismissButton: .default(Text("Ok")){
                            self.askQuestion()
                        })
                    }
                }
                Spacer()
            }
            
        }
        
        
    }
    func textForAlert() -> Text{
        if self.scoreTitle == "Wrong"{
            return Text("Your Correct score is \(self.scoreCorrect)\nYour Wrong score is \(self.scoreWrong)\nThis is the flag of \(self.countries[self.tapNumber])")
        }else{
            return Text("Your Correct score is \(self.scoreCorrect)\nYour Wrong score is \(self.scoreWrong)")
        }
    }
    func flagTapped(_ number: Int) {
        tapNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCorrect += 1
        } else {
            scoreTitle = "Wrong"
            scoreWrong += 1
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.showingOpacity[0...2] = [false, false, false]
        self.showingWrong[0...2] = [false, false, false]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

