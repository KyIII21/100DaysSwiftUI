//
//  ContentView.swift
//  16Day (Form, NavigationView, @State)
//
//  Created by Дмитрий on 15.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfPeople = 0
    @State private var checkAmount = ""
    @State private var tipPercentage = 2
    let tipPercentages = ["5", "10","15","20","0"]
    
    var totalPerPerson: Double{
        let realNofP = Double(numberOfPeople + 2)
        let realPr = Double(tipPercentages[tipPercentage])!
        let realAmount = Double(checkAmount.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)) ?? 0
        
        let tipValue = realAmount / 100 * realPr
        let grandTotal = realAmount + tipValue
        
        return grandTotal / realNofP
    }
    
    

    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                    
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("From each Person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
