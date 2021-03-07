//
//  ContentView.swift
//  CombineIntro
//
//  Created by Alexandr Glushchenko on 04.03.2021.
//

import SwiftUI
import Combine
class Test: ObservableObject {
    @Published var result: String = "Hello World!"
    private var subscriptions = Set<AnyCancellable>()
    func update() {
        let a = PassthroughSubject<Int, Never>()
        let b = PassthroughSubject<String, Never>()

        let c = a
            .map { a -> Int in
                RunLoop.current.run(until: Date().addingTimeInterval(1))
                return a
            }
        //.subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .print("info")

        Publishers.CombineLatest(b, c).map {
            "b, c, \($0), \($1)"
        }.assign(to: &$result)


//        Publishers.CombineLatest(b, c).sink {
//            print("b, c", $0, $1)
//        }.store(in: &subscriptions)

            a.send(3)
        b.send("3")
    }
}

struct ContentView: View {
    @StateObject var test = Test()

    var body: some View {
        Text(test.result)
            .padding()
            .onAppear {
                test.update()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
