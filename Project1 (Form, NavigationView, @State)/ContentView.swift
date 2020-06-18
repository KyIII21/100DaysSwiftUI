//
//  ContentView.swift
//  16Day (Form, NavigationView, @State)
//
//  Created by Дмитрий on 15.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfPeople = ""
    @State private var checkAmount = ""
    @State private var tipPercentage = 2
    let tipPercentages = ["5", "10","15","20","0"]
    
    var totalAmount: Double{
        let realPr = Double(tipPercentages[tipPercentage])!
        let realAmount = Double(checkAmount.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)) ?? 0

        let tipValue = realAmount / 100 * realPr
        return realAmount + tipValue
        
    }
    
    var totalPerPerson: Double{
        let realNofP = Double(numberOfPeople) ?? 1
       
        return totalAmount / realNofP
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
                Section(header: Text("Amount with tip")){
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
                Section {
                    TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.numberPad)
                }
                Section(header: Text("Amount per person")){
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
