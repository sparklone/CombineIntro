//: [Previous](@previous)

import Combine


var subject = PassthroughSubject<Int, Never>()
//var subject = CurrentValueSubject<Int, Never>(-1)

subject.send(0)

subject.sink { value in
    print("1: ", value)
}

subject.send(1)
subject.send(2)

subject.sink { value in
    print("2: ", value)
}

subject.send(3)
