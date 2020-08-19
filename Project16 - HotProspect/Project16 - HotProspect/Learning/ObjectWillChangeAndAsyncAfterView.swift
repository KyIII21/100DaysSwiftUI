//
//  ObjectWillChangeAndAsyncAfterView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 18.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    //@Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
        //        didSet {
        //            if value % 2 == 0 {
        //                objectWillChange.send()
        //            }
        //        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ObjectWillChangeAndAsyncAfterView: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ObjectWillChangeAndAsyncAfterView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectWillChangeAndAsyncAfterView()
    }
}
