//
//  ContentView.swift
//  Project10 - CupcakeCorner (custom Codable implementations, URLSession, the disabled() modifier)
//
//  Created by Дмитрий on 05.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    @State var showingRoot = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderInStruct.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $order.orderInStruct.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderInStruct.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.orderInStruct.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.orderInStruct.specialRequestEnabled {
                        Toggle(isOn: $order.orderInStruct.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.orderInStruct.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order, showingRoot2: self.$showingRoot ),
                    isActive: self.$showingRoot) {
                        Text("Delivery details")
                    }
                    //.isDetailLink(false)
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
