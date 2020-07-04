//
//  HabbitView.swift
//  47 Day - Challenge2 - HabitTracking
//
//  Created by Дмитрий on 03.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct HabbitView: View {
    @State var habbit: Habbit
    @ObservedObject var habbits: Habbits
    var number: Int{
        get{
            if(self.habbits.stIndex(habbit: self.habbit) != nil){
                return self.habbits.stIndex(habbit: self.habbit)!
            }else{
                return 0
            }
        }
        set{
            if(self.habbits.stIndex(habbit: self.habbit) != nil){
                number = self.habbits.stIndex(habbit: self.habbit)!
            }else{
                fatalError("Habbit not found in Habbits!")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Description:")
                    .bold()
                    .padding(.top, 25.0)
                    .padding([.top, .leading, .trailing])
                    
                Text("\(habbit.printDescription())")
                    .frame(height: 150, alignment: .top)
                    .padding()
                    .padding(.bottom, 100.0)
                    
                /*
                 Binding<Int32>(get: {
                     self.habbit.count
                 }, set: {
                     self.habbit.count = $0
                     self.habbits.arrHabbits[self.habbits.stIndex(habbit: self.habbit)!] = self.habbit
                 })
                 */
                Stepper(value: self.$habbits.arrHabbits[self.number].count, in: 0...Int32.max) {
                    HStack{
                        Text("How many times completed: ")
                            .font(.callout)
                        Spacer()
                        Text("\(self.habbits.arrHabbits[self.number].count)")
                            .bold()
                    }
                }
                .padding()
                .padding(.bottom, 150.0)
            }
            .navigationBarTitle(self.habbit.printName())
        }
        
    }
}

struct HabbitView_Previews: PreviewProvider {
    static var previews: some View {
        HabbitView(habbit: Habbits().arrHabbits[0], habbits: Habbits())
    }
}
