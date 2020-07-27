//
//  MKPointAnnotation-ObservableObject.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 27.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
