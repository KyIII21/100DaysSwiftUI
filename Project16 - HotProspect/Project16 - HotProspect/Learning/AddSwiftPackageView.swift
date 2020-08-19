//
//  AddSwiftPackageView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 19.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import SamplePackage

struct AddSwiftPackageView: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct AddSwiftPackageView_Previews: PreviewProvider {
    static var previews: some View {
        AddSwiftPackageView()
    }
}
