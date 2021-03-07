//: [Previous](@previous)

import Foundation
import Combine

let myNotification = Notification.Name("com.sparklone.myNotification")
// anchor
var subscription: AnyCancellable?
var subscriptions = Set<AnyCancellable>()

func listenToNotifications() {
    let publisher = NotificationCenter.default
        .publisher(for: myNotification)
        .print("myNotification")
//    subscription = publisher
//        .sink(receiveValue: { notification in
//            print(" - Notification received! \(Date())")
//        })

    publisher
        .sink(receiveValue: { notification in
            print(" + Notification received! \(Date())")
        })
        .store(in: &subscriptions)


    NotificationCenter.default.post(Notification(name: myNotification))
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        NotificationCenter.default.post(Notification(name: myNotification))
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        ///subscription?.cancel()
    }
}

listenToNotifications()

