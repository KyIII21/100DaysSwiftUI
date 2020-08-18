//
//  NamingView.swift
//  Day77 - Challenge (Naming Photo)
//
//  Created by Дмитрий on 17.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct NamingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    var image: UIImage
    
    var body: some View {
        VStack{
            TextField("First and Last Name", text: self.$name)
            Image(uiImage: self.image)
                .resizable()
                .frame(width: 200.0, height: 400.0)
                .aspectRatio(contentMode: .fill)

            Button("Save") {
                self.presentationMode.wrappedValue.dismiss()
            }
        .disabled(self.name == "")
        }
        .padding()
    }
}

//struct NamingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NamingView()
//    }
//}
