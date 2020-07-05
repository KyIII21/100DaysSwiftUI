//
//  Order.swift
//  Project10 - CupcakeCorner (custom Codable implementations, URLSession, the disabled() modifier)
//
//  Created by Дмитрий on 05.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    struct myOrder: Codable {
        var type = 0
        var quantity = 3

        var specialRequestEnabled = false{
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        //For AddressView
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        //Check AddressView for empty
        var hasValidAddress: Bool {
            if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
                return false
            }
            if name.hasPrefix(" ") || streetAddress.hasPrefix(" ") || city.hasPrefix(" ") || zip.hasPrefix(" "){
                return false
            }
            if zip.count < 4 || streetAddress.count < 4{
                return false
            }

            return true
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2

            // complicated cakes cost more
            cost += (Double(type) / 2)

            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }

            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }

            return cost
        }
    }

    @Published var orderInStruct = myOrder()
    
    
    //For can doing Codable Class
    enum CodingKeys: CodingKey {
        case orderInStruct
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(orderInStruct, forKey: .orderInStruct)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        orderInStruct = try container.decode(myOrder.self, forKey: .orderInStruct)
    }
    //Can create empty class
    init() { }
}

