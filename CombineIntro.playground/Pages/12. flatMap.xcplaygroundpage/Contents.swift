//: [Previous](@previous)

import Combine
import Foundation

enum CustomError: Error {
    case unknown
    case network
    case three
    case nsError(Error)
}

var subject = CurrentValueSubject<Int, Never> (1)
var subscriptions = Set<AnyCancellable>()

subject
    .map { URL(string: "https://google.com?q=\($0)")! }
    .flatMap { url in
        URLSession.shared.dataTaskPublisher(for: url)
    }
//    .flatMap { url in
//        can return new sequence
//    }
    .map({ $0.response.url })
    .print("output")
    .sink { (completion) in
        print(completion)
    } receiveValue: { (value) in
        print(value)
    }.store(in: &subscriptions)


subject.send(4)
subject.send(5)
subject.send(6)
subject.send(7)

