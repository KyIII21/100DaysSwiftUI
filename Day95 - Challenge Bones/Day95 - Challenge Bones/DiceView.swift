//
//  DiceView.swift
//  Day95 - Challenge Bones
//
//  Created by Дмитрий on 29.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    @EnvironmentObject var diceObj: DiceArray
    @State private var showSetting = false
    @State private var diceOne = ""
    @State private var diceTwo = ""
    @State private var sum: Int8 = 0
    let edges: [Int8] = [4,6,8,20,100]
    //let countEdge = 6
    @State var countEdge = 1
    @State private var counter = 0
    @State private var startRoll = false
    @State var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    func generateDices(){
        diceOne = String((1...edges[countEdge]).randomElement()!)
        diceTwo = String((1...edges[countEdge]).randomElement()!)
    }
    
    func roll(){
        //generateDices()

        if let d1Int8 = Int8(diceOne) {
            if let d2Int8 = Int8(diceTwo){
                sum = d1Int8 + d2Int8
                let dice = Dice(d1Int8, d2Int8)
                diceObj.diceArr.append(dice)
            }
        }

    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text(self.diceOne)
                        .padding()
                        
                    Text(self.diceTwo)
                        .padding()
                }
                .font(.largeTitle)
                .onReceive(timer) { time in
                    if self.startRoll{
                        if self.counter == 8 {
                            timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
                        }
                        if self.counter == 12 {
                            timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                        }
                        if self.counter == 17 {
                            timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
                        }
                        if self.counter == 19 {
                            timer = Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
                        }
                        if self.counter == 20 {
                            self.startRoll = false
                            self.roll()
                            self.counter = 0
                            self.timer.upstream.connect().cancel()
                        } else {
                            self.generateDices()
                        }

                        self.counter += 1
                    }
                }
                
                Button(action: {
                    self.startRoll = true
                    timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//                    }
                }){
                    Text("Roll the dice")
                        .foregroundColor(.white)
                        
                }
                .frame(width: 150, height: 60)
                .background(Color.gray)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 1, y: 1)
                
                Text("Sum: \(sum)")
                    .padding()
            }
            .sheet(isPresented: $showSetting){
                SettingsView(countEdge: self.$countEdge)
            }
            .navigationBarItems(trailing: Button(action: {self.showSetting.toggle()}){
                Text("Settings")
            })
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(countEdge: 1)
    }
}
