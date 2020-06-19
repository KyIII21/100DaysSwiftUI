//
//  ContentView.swift
//  Project2 (Gradients, Button, Image, Alert)
//
//  Created by Дмитрий on 18.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCorrect = 0
    @State private var scoreWrong = 0
    @State private var tapNumber = 0

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
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

