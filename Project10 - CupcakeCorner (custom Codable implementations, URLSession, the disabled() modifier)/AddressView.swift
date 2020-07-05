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

    var body: some View {
        Text("Hello World")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
