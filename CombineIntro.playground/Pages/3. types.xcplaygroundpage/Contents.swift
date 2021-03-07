//: [Previous](@previous)

import Combine

var just = Just(5)
var map = just.map (String.init)

var anotherJust = Just(6)
var mix = just.merge(with: anotherJust)
var anotherMap = mix.map(String.init)

