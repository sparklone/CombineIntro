//: [Previous](@previous)

import Combine
import Foundation

class SearchController {
    @Published var text = ""
    @Published var resultUrl: URL? = nil

    init() {
        $text
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { URL(string: "https://google.com/?q=\($0)")! }
            .flatMap (URLSession.shared.dataTaskPublisher)
            .retry(1)
            .map { $0.response.url }
            .replaceError(with: nil)
            .assign(to: &$resultUrl)
    }

}

var cancellables = Set<AnyCancellable>()

let controller = SearchController()
controller.$resultUrl
    .compactMap { $0 }
    .sink { value in
        print(value)
    }
    .store(in: &cancellables)

controller.text = "test1"
controller.text = "test2"
controller.text = "test3"
controller.text = "test4"
controller.text = "test5"
DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    controller.text = "test10"
}

// throttle
