//: [Previous](@previous)

import Combine
import Foundation

enum CustomError: Error {
    case unknown
    case network
    case nsError(NSError)
}
// PAT
//var publisher: Publisher<Int, Never> = Just<Int>(3)

// setFailureType
//var publisher: AnyPublisher<Int, CustomError> = Just<Int>(3)
//    .setFailureType(to: CustomError.self)
//    .eraseToAnyPublisher()

// convert error type
var subject = CurrentValueSubject<Int, Error>(10)
//var publisher: AnyPublisher<String, CustomError> = subject
//    .mapError({ (error) -> CustomError in
//        switch error {
//            case let error as NSError:
//                return .nsError(error)
//            default:
//                return .unknown
//        }
//    })
//    .map(square)
//    .map { "string: \($0)" }
//    .eraseToAnyPublisher()


publisher.sink { (completion) in
    print(completion)
} receiveValue: { value in
    print(value)
}

subject.send(20)





















func square(value: Int) -> Int { value * value }
