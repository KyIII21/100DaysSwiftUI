//
//  ContentView.swift
//  Project8 - Moonshot (GeometryReader, ScrollView, NavigationLink)
//
//  Created by Дмитрий on 28.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
    
    init(){
        name = ""
        address = Address(street: "", city: "")
    }
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    @State private var newUser = User()
    var body: some View {
        VStack{
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """

                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data) {
                    self.newUser = user
                }
            }
                .padding()
            Text("User Address: \(self.newUser.address.street)")
        }
        .navigationBarTitle("SwiftUI")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
