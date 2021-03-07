//: [Previous](@previous)

import Foundation
import Combine

let myNotification = Notification.Name("com.sparklone.myNotification")
// anchor
var subscription: AnyCancellable?

func listenToNotifications() {
    subscription = NotificationCenter.default
        .publisher(for: myNotification)
        .sink(receiveValue: { notification in
            print("Notification received! \(Date())")
        })

    NotificationCenter.default.post(Notification(name: myNotification))
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        NotificationCenter.default.post(Notification(name: myNotification))
    }
}

listenToNotifications()

