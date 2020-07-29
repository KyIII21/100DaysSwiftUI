//
//  HidingGrouping.swift
//  Project15 - Accessibility
//
//  Created by Дмитрий on 30.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct HidingGrouping: View {
    var body: some View {
        VStack {
            Image(decorative: "character")
                .accessibility(hidden: true)
            
            Text("Your score is")
            Text("1000")
                .font(.title)
        }//Прочтет элементы вместе
        .accessibilityElement(children: .combine)
        //Аналог и без задержек читает
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Your score is 1000"))
    }
}

struct HidingGrouping_Previews: PreviewProvider {
    static var previews: some View {
        HidingGrouping()
    }
}
