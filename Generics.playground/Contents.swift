import UIKit

class Guide {
    func genericSwap<T>(firstVal: inout T, secondVal: inout T) {
        let temporaryA = firstVal
        firstVal = secondVal
        secondVal = temporaryA
    }
}


var firstVal = 1
var secondVal = 2

print("First value... \(firstVal)")
print("Second value... \(secondVal)")

Guide().genericSwap(firstVal: &firstVal, secondVal: &secondVal)

print("New first value... \(firstVal)")
print("New second value... \(secondVal)")
