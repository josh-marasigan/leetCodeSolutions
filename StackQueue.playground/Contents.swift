import UIKit

struct Stack<T> {
    var array = [T]()
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        if !array.isEmpty {
            // O(1)
            return array.removeLast()
        }
        return nil
    }
    
    func peek() -> T? {
        if !array.isEmpty {
            return array[array.count - 1]
        }
        return nil
    }
}

struct Queue<T> {
    var list = [T]()
    
    mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    mutating func dequeue() -> T? {
        if !list.isEmpty {
            // O(N)
            return list.removeFirst()
        }
        return nil
    }
    
    func peek() -> T? {
        if !list.isEmpty {
            return list[0]
        } else {
            return nil
        }
    }
    
    var isEmpty: Bool {
        return list.isEmpty
    }
}
