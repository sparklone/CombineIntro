//: [Previous](@previous)

import Combine
import Foundation

func createFuture(url: URL) -> AnyPublisher<URL?, Never> {
//    Deferred {
        Future { promise in
            print("start work: \(Date())")
            let task = URLSession.shared
                .dataTask(with: url) { data, response, error in
                    promise(.success(response?.url))
                    print("end work: \(Date())")
                }
            task.resume()
        }
        .eraseToAnyPublisher()

//    }
//    .eraseToAnyPublisher()

}

let url = URL(string: "https://google.com")!
createFuture(url: url)
//    .sink { (completion) in
//        print(completion)
//    } receiveValue: { value in
//        print(value)
//    }
