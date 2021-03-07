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
//    .map { value in
//        if value % 3 == 0 {
//            throw CustomError.three
//        }
//        return value
//    }
//    .tryMap { value in
//        if value % 3 == 0 {
//            throw CustomError.three
//        }
//        return value
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
