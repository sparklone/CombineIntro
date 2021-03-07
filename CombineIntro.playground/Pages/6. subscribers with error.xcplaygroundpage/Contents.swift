//: [Previous](@previous)

import Combine

enum CustomError: Error {
    case unknown
    case network
    case nsError(Error)
}

var store = Set<AnyCancellable>()
var subjectWithError = CurrentValueSubject<Int, CustomError> (0)

subjectWithError.sink { completion in
    switch completion {
        case .finished:
            print("success")
        case let .failure(error):
            print("error: \(error)")
    }
} receiveValue: { value in
    print("value: \(value)")
}

//subject.sink can't without processing error
subjectWithError.send(7)
subjectWithError.send(completion: .finished)
subjectWithError.send(8)
// subjectWithError.assign can't because of error
