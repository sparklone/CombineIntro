//: [Previous](@previous)

import Combine
import UIKit

var subscriptions = Set<AnyCancellable>()

(0...10).publisher
    .map { URL(string: "https://google.com?q=\($0)")! }
    .print("input")
    .flatMap { url in
//    .flatMap(maxPublishers: .max(1)) { url in
//        URLSession.shared.dataTaskPublisher(for: url)
//    }
    .map({ $0.response.url })
    .print("output")
    .sink { (completion) in
        print(completion)
    } receiveValue: { (value) in
        print(value)
    }.store(in: &subscriptions)
