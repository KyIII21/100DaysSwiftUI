//
//  ContentView.swift
//  19 Day - Challenge
//
//  Created by Дмитрий on 18.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var length = 0
    @State private var lengthOut = 0
    @State private var lengthValue = ""
    private let lengthConversion = ["meters", "kms", "feet", "yards", "miles"]
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Input unit")){
                    Picker("Choice", selection: $length) {
                        ForEach(0 ..< lengthConversion.count){
                            Text("\(self.lengthConversion[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Input value")){
                    TextField("Write value..", text: $lengthValue)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Output unit")){
                    Picker("Choice", selection: $lengthOut) {
                        ForEach(0 ..< lengthConversion.count){
                            Text("\(self.lengthConversion[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output Result")){
                    Text("\(self.calcOutLength(), specifier: "%.2f") \(lengthConversion[self.lengthOut])")
                }
            }
            .navigationBarTitle("Auto Conversion")
        }
    }
    func calcOutLength() -> Double{
        guard let checkDouble = Double(self.lengthValue) else{
            return 0
        }
        
        let lengthIn = lengthConversion[self.length]
        let lengthOut = lengthConversion[self.lengthOut]
        
        if lengthOut == lengthIn{
            return checkDouble
        }
        
        switch lengthIn {
        case "meters" where lengthOut == "kms" :
            return checkDouble / 1000
        case "meters" where lengthOut == "feet" :
            return checkDouble * 3.281
        case "meters" where lengthOut == "yards" :
            return checkDouble * 1.094
        case "meters" where lengthOut == "miles" :
            return checkDouble / 1609
        case "kms" where lengthOut == "meters" :
            return checkDouble * 1000
        case "kms" where lengthOut == "feet" :
            return checkDouble * 3.281 * 1000
        case "kms" where lengthOut == "yards" :
            return checkDouble * 1.094 * 1000
        case "kms" where lengthOut == "miles" :
            return checkDouble / 1609 * 1000
        case "feet" where lengthOut == "kms" :
            return checkDouble / 1000 / 3.281
        case "feet" where lengthOut == "meters" :
            return checkDouble / 3.281
        case "feet" where lengthOut == "yards" :
            return checkDouble * 1.094 / 3.281
        case "feet" where lengthOut == "miles" :
            return checkDouble / 1609 / 3.281
        case "yards" where lengthOut == "kms" :
            return checkDouble / 1000 / 1.094
        case "yards" where lengthOut == "feet" :
            return checkDouble * 3.281 / 1.094
        case "yards" where lengthOut == "meters" :
            return checkDouble / 1.094
        case "yards" where lengthOut == "miles" :
            return checkDouble / 1609 / 1.094
        case "miles" where lengthOut == "kms" :
            return checkDouble / 1000 * 1609
        case "miles" where lengthOut == "feet" :
            return checkDouble * 3.281 * 1609
        case "miles" where lengthOut == "yards" :
            return checkDouble * 1.094 * 1609
        case "miles" where lengthOut == "meters" :
            return checkDouble * 1609
        default:
            return 0
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
