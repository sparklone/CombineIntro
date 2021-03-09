//: [Previous](@previous)

import Combine
import SwiftUI
import PlaygroundSupport

var store = Set<AnyCancellable>()
class ViewModel: ObservableObject {
    @Published var i = 0

    func getData() {
        //...
        let subject = PassthroughSubject<Int, Never>()
        subject.assign(to: &$i)

        subject.send(i + 1)
    }
}

//struct T {
//    @Published var i = 0
//}

let vm = ViewModel()
vm.$i
    .sink { (value) in
        print(value)
    }.store(in: &store)

vm.getData()
vm.getData()
vm.getData()


struct MyView: View {
    @StateObject var vm = ViewModel()
    //@State var secondVar: Int = 0
    var body: some View {
        Text("\(vm.i)")
        Button(action: {
            vm.getData()
        }, label: {
            Text("Get data")
        })
//        .onReceive(vm.$i.eraseToAnyPublisher(), perform: { value in
//            print(value)
//            secondVar = value
//        })
    }
}

PlaygroundPage.current.setLiveView(
    MyView()
        .frame(width: 320, height: 480, alignment: .center)
)
