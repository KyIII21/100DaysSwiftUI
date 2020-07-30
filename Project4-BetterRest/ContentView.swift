//
//  ContentView.swift
//  Project4-BetterRest
//
//  Created by Дмитрий on 20.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

extension Double {
  func inTime() -> String {
    let wholeNumber = Int(self)
    let afterPoint = self - Double(wholeNumber)
    if afterPoint == 0 {
        return String(wholeNumber) + " hours"
    }
    let minute = Int(afterPoint * 60)
    return String(wholeNumber) + " hours and " + String(minute) + " minuts"
  }
}

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount = 1
    func youNeedSleep() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        //.labelsHidden()
                }

                Section(header: Text("Desired amount of sleep")){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .accessibility(value: Text("\(sleepAmount.inTime())"))
                }
                
                Section(header: Text("Daily coffee intake")){
                    Picker("Choice count", selection: $coffeeAmount){
                        ForEach(1..<21){numb in
                            if numb == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(numb) cups" + "")
                            }
                        }
                    }
                }
                
                Section(header: Text("Go to bed at")
                    .font(.headline)
                    ){
                    Text(youNeedSleep())
                    .bold()
                }
                
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
