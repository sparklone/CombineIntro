//: [Previous](@previous)

import Combine

var counter = 0
(0...10)
    .publisher
    .handleEvents(receiveSubscription: { subscription in

    }, receiveOutput: { value in
        if value % 2 == 0 {
            counter += 1
        }
    }, receiveCompletion: { completion in
        print("completion: \(counter)")
    }, receiveCancel: {

    }, receiveRequest: { demand in

    })

    .sink { (completion) in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
