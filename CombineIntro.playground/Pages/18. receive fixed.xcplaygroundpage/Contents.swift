//: [Previous](@previous)

import Foundation
import Combine

extension Notification.Name {
    public static let didPost = Notification.Name("didPost")
}

func postNotifications() {
    let names = ["aaa", "bbb", "ccc"]

    for name in names {
        NotificationCenter.default.post(
            name: .didPost,
            object: nil,
            userInfo: ["Car" : name]
        )
    }
}

let cancellable = NotificationCenter.default.publisher(for: .didPost)
    .compactMap { $0.userInfo?["Car"] as? String }
    .receive(on: RunLoop.main) // already fixed problem
    .sink {
        print("sink: \($0)")
    }

postNotifications()
