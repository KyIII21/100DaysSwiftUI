//
//  AddressView.swift
//  Project10 - CupcakeCorner (custom Codable implementations, URLSession, the disabled() modifier)
//
//  Created by Дмитрий on 05.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    @Binding var showingRoot2: Bool

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderInStruct.name)
                TextField("Street Address", text: $order.orderInStruct.streetAddress)
                TextField("City", text: $order.orderInStruct.city)
                TextField("Zip", text: $order.orderInStruct.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order, showingRoot3: self.$showingRoot2)) {
                    Text("Check out")
                }
                .isDetailLink(false)
            }
            .disabled(order.orderInStruct.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

/*struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
*/
