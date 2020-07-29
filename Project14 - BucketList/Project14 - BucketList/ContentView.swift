//
//  ContentView.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 24.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import LocalAuthentication



struct ContentView: View {    
    @State private var isUnlocked = false
    @State private var showingUnlockAlert = false
    @State private var errorAuthenticateMessage = ""
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.errorAuthenticateMessage = authenticationError?.localizedDescription ?? "Unknown Error in evaluatePolicy"
                        self.showingUnlockAlert.toggle()
                    }
                }
            }
        } else {
            // no biometrics
            self.errorAuthenticateMessage = error?.localizedDescription ?? "Unknown Error in canEvaluatePolicy (No Biometrics)"
            self.showingUnlockAlert.toggle()
        }
    }

    var body: some View {
        ZStack{
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: self.$showingUnlockAlert){
            Alert(title: Text("Sorry"), message: Text("\(self.errorAuthenticateMessage)"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Repeat again"), action: {
                self.authenticate()
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
