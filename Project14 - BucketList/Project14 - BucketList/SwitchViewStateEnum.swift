//
//  SwitchViewStateEnum.swift
//  Project14 - BucketList
//
//  Created by Дмитрий on 25.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct SwitchViewStateEnum: View {
    var loadingState = LoadingState.loading

    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchViewStateEnum_Previews: PreviewProvider {
    static var previews: some View {
        SwitchViewStateEnum()
    }
}
