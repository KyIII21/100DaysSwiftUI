//
//  EditView.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 27.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
            }
            .navigationBarTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(placemark: MKPointAnnotation.example)
//    }
//}
