//: [Previous](@previous)

import Combine
import Foundation

let a = PassthroughSubject<Int, Never>()
let b = PassthroughSubject<String, Never>()
var backgroundQueue: DispatchQueue = DispatchQueue(label: "background")

let c = a
    .map { a -> Int in
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        return a
    }
    
    .subscribe(on: DispatchQueue.global())
    //.subscribe(on: backgroundQueue)
    .receive(on: DispatchQueue.main)
    .print()

let cancellable = Publishers.CombineLatest(b, c)
    //.subscribe(on: DispatchQueue.global())
    //.subscribe(on: backgroundQueue)
    .sink {
    print("b, c", $0, $1)
}
a.send(3)
b.send("3")
