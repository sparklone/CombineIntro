//: [Previous](@previous)

import Combine

enum CustomError: Error {
    case unknown
    case network
    case three
    case nsError(Error)
}

var subject = CurrentValueSubject<Int, CustomError> (1)

subject
    .map(square)
    .map(String.init)
    .map { "modified string: \($0)" }
//    .map { value in
//        let result = square(value: value)
//        let string = String.init(result)
//        return "modified string: \(string)"
//    }
    .sink { (completion) in
        print(completion)
    } receiveValue: { value in
        print(value)
    }


subject.send(4)
subject.send(5)
subject.send(6)
subject.send(7)
func square(value: Int) -> Int { value * value }
