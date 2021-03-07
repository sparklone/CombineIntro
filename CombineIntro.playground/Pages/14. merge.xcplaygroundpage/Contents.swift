//: [Previous](@previous)

import Combine
import CombineExt

class ViewModel {
    @Published var activate = false

    init(
        buttonTap: AnyPublisher<Void, Never>,
        gesture: AnyPublisher<Void, Never>,
        login: AnyPublisher<String, Never>
    ) {
        let isValid = login
            .map{ [weak self] login -> Bool in
                guard let self = self else { return false }
                return self.validate(login: login)
            }
        buttonTap
            .merge(with: gesture)
            .combineLatest(isValid)
            .map { $0.1 }
//            .withLatestFrom(isValid)
            .eraseToAnyPublisher()
            .assign(to: &$activate)
    }

    private func validate(login: String) -> Bool {
        login.count > 3
    }

}

let buttonSubject = PassthroughSubject<Void, Never>()
let gestureSubject = PassthroughSubject<Void, Never>()
let loginSubject = PassthroughSubject<String, Never>()

let vm = ViewModel(
    buttonTap: buttonSubject.eraseToAnyPublisher(),
    gesture: gestureSubject.eraseToAnyPublisher(),
    login: loginSubject.eraseToAnyPublisher()
)

vm.$activate.sink { (value) in
    print(value)
}

buttonSubject.send()
gestureSubject.send()
loginSubject.send("te")
gestureSubject.send()
loginSubject.send("tes")
loginSubject.send("test")
buttonSubject.send()
