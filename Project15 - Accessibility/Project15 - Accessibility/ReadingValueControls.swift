//
//  ReadingValueControls.swift
//  Project15 - Accessibility
//
//  Created by Дмитрий on 30.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ReadingValueControls: View {
    @State private var estimate = 25.0
    @State private var rating = 3

    var body: some View {
        VStack{
            Slider(value: $estimate, in: 0...50)
                .padding()
                //Чтобы читал не в процентах а в нужных нам величинах
                .accessibility(value: Text("\(Int(estimate))"))
            
            Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
                .accessibility(value: Text("\(rating) out of 5"))
        }
    }
}

struct ReadingValueControls_Previews: PreviewProvider {
    static var previews: some View {
        ReadingValueControls()
    }
}
