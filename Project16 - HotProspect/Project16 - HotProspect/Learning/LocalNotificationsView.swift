//
//  LocalNotificationsView.swift
//  Project16 - HotProspect
//
//  Created by Дмитрий on 19.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import UserNotifications

// Remote notifications require a server to work, because you send your message to Apple’s push notification service (APNS), which then forwards it to users.

struct LocalNotificationsView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    } else{
                        print("Unknown Error in Notification!")
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsView()
    }
}
