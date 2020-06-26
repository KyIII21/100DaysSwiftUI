//
//  ContentView.swift
//  Project7 - IExpense ( @ObservedObject, sheet(), onDelete() )
//
//  Created by Дмитрий on 26.06.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    @State private var showingUser = false
    @State private var newUser = User(firstName: "", lastName: "")

    var body: some View {
        VStack{
            Button("Save User") {
                let encoder = JSONEncoder()

                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            
            Button("Print User from Data"){
                let decoder = JSONDecoder()
                
                if let newUser = try? decoder.decode(User.self, from: UserDefaults.standard.data(forKey: "UserData")!){
                    
                    self.newUser = newUser
                    self.showingUser.toggle()
                }
                
            }
            .sheet(isPresented: $showingUser){
                Text("\(self.newUser.firstName)")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
