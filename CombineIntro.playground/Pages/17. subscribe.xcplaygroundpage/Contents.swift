//: [Previous](@previous)

import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()
var backgroundQueue: DispatchQueue = DispatchQueue(label: "background")

struct LogThread: Publisher {
    typealias Output = String
    typealias Failure = Never

    func receive<S>(subscriber: S)
    where S : Subscriber,
          S.Input == String,
          S.Failure == Never {

        debugPrint("Thread: \(Thread.current)")
        subscriber.receive(subscription: Subscriptions.empty)

        DispatchQueue.main.async {
            _ = subscriber.receive("logThread")
        }
    }
}


LogThread()
    //.subscribe(on: backgroundQueue)
    //.receive(on: backgroundQueue)
    .sink { _ in
        print("Sink: \(Thread.current)")
    }
    .store(in: &subscriptions)
