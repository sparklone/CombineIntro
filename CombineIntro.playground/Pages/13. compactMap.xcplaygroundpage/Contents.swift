//: [Previous](@previous)

import Combine

(0...10)
    .publisher
    .map { value in
        value % 2 == 0 ? nil : value
    }
    //.compactMap { $0 }
    .sink { (completion) in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
