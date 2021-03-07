//: [Previous](@previous)

import Foundation
import Combine

enum MyError: Error {
    case fail
}
var subscriptions = Set<AnyCancellable>()

Fail(outputType: Void.self, failure: MyError.fail)
    .delay(for: 1, scheduler: DispatchQueue.main)
    .sink(receiveCompletion: { completion in
        switch completion {
            case .finished: print("Finished")
            case .failure(let error): print("Error \(error)")
        }
    }, receiveValue: { value in
        print("Value: \(value)")
    })
    .store(in: &subscriptions)
