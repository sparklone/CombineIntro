//: [Previous](@previous)

import Combine
import Foundation

var backgroundQueue: DispatchQueue = DispatchQueue(label: "background")
var subject = PassthroughSubject<Int, Never>()

subject
    //    .receive(on: backgroundQueue)
    .map { value in
        print("map thread: \(Thread.current)")
        return value
    }
    //    .subscribe(on: backgroundQueue)
    //    .receive(on: backgroundQueue)
    .print("thread: \(Thread.current)")
    .sink { (completion) in
        print("thread: \(Thread.current)", completion)
    } receiveValue: { value in
        print("thread: \(Thread.current)", value)
    }

subject.send(1)


