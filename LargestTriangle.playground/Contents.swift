import UIKit

class Solution {
    func largestTriangleArea(_ points: [[Int]]) -> Double {
        
        var currentMax = 0.0
        for firstTriangle in 0 ..< points.count - 2 {
            for secondTriangle in firstTriangle + 1 ..< points.count - 1 {
                for thirdTriangle in secondTriangle + 1 ..< points.count {
                    
                    print("1.. \(points[firstTriangle])")
                    print("2.. \(points[secondTriangle])")
                    print("3.. \(points[thirdTriangle])")

                    let localMax = self.calculateHeight(
                        points[firstTriangle],
                        points[secondTriangle],
                        points[thirdTriangle]
                    )
                    
                    let absoluteArea = abs(localMax)
                    if absoluteArea > currentMax {
                        currentMax = absoluteArea
                    }
                }
            }
        }
        
        return currentMax
    }
    
    private func calculateHeight(_ first: [Int], _ second: [Int], _ third: [Int]) -> Double {
        let x = 0; let y = 1
        
        // O(3*2) -> O(C)
        let x1 = Double(first[x])
        let x2 = Double(second[x])
        let x3 = Double(third[x])
        let y1 = Double(first[y])
        let y2 = Double(second[y])
        let y3 = Double(third[y])
        
        // Matrix of 1/2 * |AB x AC|
        let area = x1*y2 - x1*y3 + x2*y3 - x2*y1 + x3*y1 - x3*y2
        return Double(area * 0.5)
    }
}

let points = [[4,6],[6,5],[3,1]]
let sol = Solution().largestTriangleArea(points)

print(sol)
