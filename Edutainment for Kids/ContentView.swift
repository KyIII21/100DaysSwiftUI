//
//  ContentView.swift
//  Edutainment for Kids
//
//  Created by Дмитрий on 23.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var choiceLevel = 6
    @State private var choiceCountQuestion = 2
    private let choiceCountQuestions = [5, 10, 20, 30, 50, 0]
    @State private var animationButton: Double = 1.7
    @State private var showingSecond = true
    @State private var argumentFirst = 2
    @State private var argumentSecond = 2
    @State private var resulExample = 0
    @State private var optionsAnswer: [Int] = []
    @State private var countGame = 0
    @State private var showingResult = false
    @State private var rightAnswers = 0
    @State private var wrongAnswer = Array(repeating: false, count: 9)
    @State private var correctAnswer = Array(repeating: false, count: 9)
    @State private var showingOpacity = Array(repeating: false, count: 9)
    @State private var showingNextButton = false
    
    func buttonRow(count: Int) -> some View {
        return HStack(spacing: 30){
                ForEach(3 * count ..< 3 + 3 * count) { number in
                Button(action: {
                    
                    if self.optionsAnswer[number] == self.resulExample {
                        self.rightAnswers += 1
                        self.correctAnswer[number] = true
                    }else{
                        self.wrongAnswer[number] = true
                        if let index = self.optionsAnswer.firstIndex(of: self.resulExample){
                            self.correctAnswer[index] = true
                        }else{
                            //Error
                            self.stopGame()
                        }
                    }
                    for item in 0...8 {
                        if item != self.wrongAnswer.firstIndex(of: true) && item != self.correctAnswer.firstIndex(of: true) {
                            self.showingOpacity[item] = true
                        }
                    }
                    self.showingNextButton = true
                    //self.startGame()
                }){
                    Text("\(self.optionsAnswer[number])")
                        .fontWeight(.bold)
                        .font(.headline)
                        .frame(width: 70.0, height: 70.0)
                        //.background(Color.white)
                        .animation(nil)
                        .background(self.wrongAnswer[number] ?  Color.red : Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                        .background(self.correctAnswer[number] ?  Color.green : Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                        .opacity(self.showingOpacity[number] ? 0.2 : 1)
                        .animation(
                            Animation.easeOut(duration: 1)
                        )
                        .cornerRadius(15)
                        .foregroundColor(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke( Color.black, lineWidth: 2)
                        )
                        .padding(.top, 20)
                        .alert(isPresented: self.$showingResult){
                            Alert(title: self.countGame > self.choiceCountQuestions[self.choiceCountQuestion] ? Text("Mission Complete!") : Text("Stop Game!"), message: Text("Score: \nRight Answers: \(self.rightAnswers) \n Error Answers: \(self.countGame - 1 - self.rightAnswers)"), dismissButton: .default(Text("Ok")){self.stopGame()})
                        }
                    
                    }
                
            }
        }
    }
    
    func stopGame() {
        showingSecond = true
        countGame = 0
        rightAnswers = 0
        wrongAnswer = Array(repeating: false, count: 9)
        correctAnswer = Array(repeating: false, count: 9)
        showingOpacity = Array(repeating: false, count: 9)
        showingNextButton = false
    }
    func startGame(){
        countGame += 1
        generateArguments()
        generateOptions()
        wrongAnswer = Array(repeating: false, count: 9)
        correctAnswer = Array(repeating: false, count: 9)
        showingOpacity = Array(repeating: false, count: 9)
        showingSecond = false
        showingNextButton = false
    }
    
    func generateArguments(){
        argumentFirst = Int.random(in: 2 ..< choiceLevel+1)
        argumentSecond = Int.random(in: 0 ..< 12)
        resulExample = argumentFirst * argumentSecond
    }
    
    func generateOptions(){
        optionsAnswer.removeAll()
        optionsAnswer.append(resulExample)
        while optionsAnswer.count != 9 {
            let randInt = Int.random(in: 0 ..< 11 * choiceLevel + 1)
            if !optionsAnswer.contains(randInt) {
                optionsAnswer.append(randInt)
            }
        }
        optionsAnswer.shuffle()
    }
    
    var body: some View {
        ZStack{
            if self.showingSecond {
                NavigationView{
                    VStack(spacing: 15){
                        Section(header: Text("Level of Complexity")){
                            Picker("Level", selection: $choiceLevel){
                                ForEach(2 ..< 12) {
                                    Text("\($0)")
                                }
                            
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 50.0)
                            .padding(.horizontal)
                        }
                        Section(header: Text("Number of Questions")){
                            Picker("Count", selection: $choiceCountQuestion){
                                ForEach(0 ..< choiceCountQuestions.count) {
                                    self.choiceCountQuestions[$0] != 0 ? Text("\(self.choiceCountQuestions[$0])") : Text("∞")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 140.0)
                            .padding(.horizontal)
                        }
                        
                        Section{

                            Button(action: {
                                self.startGame()
                            }){
                                Text("Start")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .padding(20)
                                    .padding(.horizontal, 100)
                                    .background(Color.green)
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.green, lineWidth: 2)
                                            .scaleEffect(CGFloat(self.animationButton))
                                            .opacity(Double(1.7 - self.animationButton))
                                            .animation(
                                                Animation.easeOut(duration: 1.5)
                                                    .repeatForever(autoreverses: false)
                                            )
                                        .onAppear{
                                            self.animationButton = 1
                                    })
                                    
                                
                            }
                        }
                    }
                    .navigationBarTitle("Edutainment for Kids")
                }
            }else{
                NavigationView{
                    VStack{
                        Section{
                            Text("№ \(self.countGame)")
                                .font(.headline)
                                .padding(10)
                                .padding(.bottom, 60.0)
                                //.frame(width: 70, height: 70, alignment: .topLeading)
                        }
                        
                        Section(){
                            HStack{
                                Text("\(argumentFirst)") + Text(" x ") + Text("\(argumentSecond)") + Text(" =")
                            }
                            .font(.largeTitle)
                            .padding(50)
                            .padding(.bottom, 60.0)
                            
                        }
                        
                        
                        Section(){
                            self.buttonRow(count: 0)
                            self.buttonRow(count: 1)
                            self.buttonRow(count: 2)
                        }
                        
                        if self.showingNextButton {
                            Section(){
                                Button(action: {
                                    if self.countGame == self.choiceCountQuestions[self.choiceCountQuestion] {
                                        self.showingResult = true
                                    }
                                    self.startGame()
                                }){
                                    Text("Next")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        .padding(10)
                                        .padding(.horizontal, 90)
                                        .background(Color.green)
                                        .clipShape(Capsule())
                                        .foregroundColor(.white)
                                        .animation(
                                            Animation.easeOut(duration: 1)
                                        )
                                }
                                .padding(.top, 41)
                            }
                        }
                        else{
                            Text("")
                                .padding(40)
                        }
                    }
                    .padding(.bottom, 100.0)
                    .navigationBarItems(trailing:  Button(action: {self.showingResult.toggle()}){ Text("Stop").foregroundColor(.red)}
                    )
                    
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
