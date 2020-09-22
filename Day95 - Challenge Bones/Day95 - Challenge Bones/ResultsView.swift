//
//  ResultsView.swift
//  Day95 - Challenge Bones
//
//  Created by Дмитрий on 29.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var diceObj: DiceArray
    
    var body: some View {
        List{
            ForEach(diceObj.diceArr.reversed(), id: \.self){ rollDice in
                Text("\(rollDice.returnDice) / Sum: \(rollDice.sum())")
            }
            .onDelete(perform: diceObj.deleteDice)
        }

    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
