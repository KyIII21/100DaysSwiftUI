//
//  EnvironmentObjectView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 18.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectView: View {
    let user = User()
    
    var body: some View {
        //        VStack {
        //            EditView().environmentObject(user)
        //            DisplayView().environmentObject(user)
        //        }
                VStack {
                    EditView()
                    DisplayView()
                }
                .environmentObject(user)
    }
}

struct EnvironmentObjectView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectView()
    }
}
