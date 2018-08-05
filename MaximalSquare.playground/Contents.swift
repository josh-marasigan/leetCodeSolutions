import UIKit

class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0 else { return 0 }
        
        var cache: [[Int]] = Array(repeating: Array(repeating: 0, count: matrix[0].count),
                                   count: matrix.count)
        
        for i in matrix.count {
            for j in matrix[x].count {
                cache[i][j] = matrix[i][j]
            }
        }
        
        var maxSquare = 0
        for x in matrix.count {
            for y in matrix[x].count {
                guard x != 0 && y != 0 else { continue }
                
                // cache[x][y] = 1 + Int.min(cache[x],[y])
            }
        }
        
        return maxSquare*maxSquare
    }
}
