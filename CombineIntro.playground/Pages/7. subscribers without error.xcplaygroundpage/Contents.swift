//: [Previous](@previous)

import Combine
// struct
class Test {
    var i: Int = 0 {
        didSet {
            print("var i: \(i)")
        }
    }

    var j: Int? = nil
}

var test = Test()
var subjectWithoutError = CurrentValueSubject<Int, Never> (0)
subjectWithoutError.assign(to: \.i, on: test)
//subjectWithoutError.assign(to: \.j, on: test)

var optionalSubjectWithoutError = CurrentValueSubject<Int?, Never> (0)
//optionalSubjectWithoutError.assign(to: \.i, on: test)

//optionalSubjectWithoutError
//    //.compactMap { $0 }
//    .replaceNil(with: -1)
//    .assign(to: \.i, on: test)

subjectWithoutError.send(10)
subjectWithoutError.send(20)
//subjectWithoutError.send(completion: .finished)
subjectWithoutError.send(30)
//subjectWithoutError.send(completion: .failure(.network))
subjectWithoutError.send(40)

class VM: ObservableObject {
    @Published var i = 0

    func getData() {
        //...
        let subject = PassthroughSubject<Int, Never>()
        subject.assign(to: &$i)
        subject.assign(to: \.i, on: self)

        subject.send(i + 1)
    }
}

