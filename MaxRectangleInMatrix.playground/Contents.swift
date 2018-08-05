
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
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0 else { return 0 }
        
        var histogram: [Int] = Array(repeating: 0, count: matrix[0].count)
        var maxRectangle = 0
        
        for row in matrix {
            self.updateHistogram(row, &histogram)
            
            let localMaxArea = self.largestRectangle(histogram)
            if localMaxArea > maxRectangle {
                maxRectangle = localMaxArea
            }
        }
        
        return maxRectangle
    }
    
    private func updateHistogram(_ currentRow: [Character], _ histogram: inout [Int]) {
        var i = 0
        for index in currentRow {
            guard index != "0" else {
                histogram[i] = 0
                i += 1
                continue
            }
            
            histogram[i] += 1
            i += 1
        }
    }
    
    private func largestRectangle(_ heights: [Int]) -> Int {
        
        var stack = Stack<Int>()
        var maxArea = 0
        var index = 0
        
        while index < heights.count {
            if stack.isEmpty() {
                stack.push(index)
                index += 1
                continue
            } else if let peek = stack.peek(), heights[peek] <= heights[index] {
                stack.push(index)
                index += 1
                continue
            }
            
            // Look back
            if let localMax = stack.pop() {
                let area = stack.isEmpty() ?
                    
                    // Evaluating single column
                    heights[localMax] * (index) :
                    
                    // Evaluating current column vs. next comparable height
                    heights[localMax] * ((index - 1) - (stack.peek() ?? 0))
                
                if area > maxArea {
                    maxArea = area
                }
            }
        }
        
        // Evaluate remaining elements
        while let currentIndex = stack.pop() {
            
            let area = stack.isEmpty() ?
                
                // Evaluating single column
                heights[currentIndex] * (index) :
                
                // Evaluating current column vs. next comparable height
                heights[currentIndex] * ((index - 1) - (stack.peek() ?? 0))
            
            if area > maxArea {
                maxArea = area
            }
        }
        
        return maxArea
    }
}

let matrix: [[Character]] = [
                ["1","0","1","0","0"],
                ["1","0","1","1","1"],
                ["1","1","1","1","1"],
                ["1","0","0","1","0"]
            ]
let sol = Solution().maximalRectangle(matrix)

print(sol)


