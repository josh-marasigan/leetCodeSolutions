import UIKit

struct Stack<Int> {
    private var stack = [Int]()
    
    mutating func push(_ element: Int) {
        stack.append(element)
    }
    
    mutating func pop() -> Int? {
        return !stack.isEmpty ? stack.removeLast() : nil
    }
    
    func peek() -> Int? {
        return !stack.isEmpty ? stack[stack.count - 1] : nil
    }
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
}

class Solution {
    
    func largestRectangleArea(_ heights: [Int]) -> Int {
        
        var stack = Stack<Int>()
        var maxArea = 0
        var index = 0
        
        // Find areas by traversing the index
        while index < heights.count {
            
            // If new index height is shorter, go back and calculate previous heights
            guard let peek = stack.peek(), heights[peek] > heights[index] else {
                stack.push(index)
                index += 1
                continue
            }
            
            if let localMax = stack.pop() {
                let area = stack.isEmpty() ?
                    heights[localMax] * (index) :
                    heights[localMax] * ((index - 1) - (stack.peek() ?? 0))
                if area > maxArea {
                    maxArea = area
                }
            }
        }
        
        // Some elements (less than the last index value) remain
        while let currentIndex = stack.pop() {
            let area = stack.isEmpty() ?
                heights[currentIndex] * (index) :
                heights[currentIndex] * ((index - 1) - (stack.peek() ?? 0))
            if area > maxArea {
                maxArea = area
            }
        }
        
        return maxArea
    }
}

let heights = [9,0] //[2,1,5,6,2,3]
let sol = Solution().largestRectangleArea(heights)
