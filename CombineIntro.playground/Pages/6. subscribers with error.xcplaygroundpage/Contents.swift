//: [Previous](@previous)

import Combine

enum CustomError: Error {
    case unknown
    case network
    case nsError(Error)
}

var store = Set<AnyCancellable>()
var subjectWithError = CurrentValueSubject<Int, CustomError> (0)

subjectWithError
    .print("subjectWithError")
    .sink { completion in
    switch completion {
        case .finished:
            print("success")
        case let .failure(error):
            print("error: \(error)")
    }
} receiveValue: { value in
    print("value: \(value)")
}

// 1. subject.sink can't without processing error

subjectWithError.send(7)
subjectWithError.send(completion: .finished)
subjectWithError.send(8)

class T {
    var i: Int = 0
}

var t = T()
// 2. subjectWithError.assign can't because of error
// subjectWithError.assign(to: \.i, on: t)
