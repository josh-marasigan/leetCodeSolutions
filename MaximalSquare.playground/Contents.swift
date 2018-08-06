import UIKit

/*
 Different approach to copying matrix in swift:
 
 let ca: [[Int]] = matrix.map { (row) -> [Character] in
 return row
 }.map { (val) -> [Int] in
 var row = [Int]()
 for i in val {
 row.append(Int(String(i)) ?? 0)
 }
 return row
 }
 */

class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0 else { return 0 }
        
        var cache: [[Int]] = Array(
            repeating: Array(repeating: 0, count: matrix[0].count),
            count: matrix.count)
        
        var maxSquare = 0
        
        for x in 0 ..< matrix.count {
            for y in 0 ..< matrix[x].count {
                guard (x != 0 && y != 0), (matrix[x][y] != "0") else {
                    // Case: Only viable square area exists within the first row/column
                    cache[x][y] = matrix[x][y] == "0" ? 0 : 1
                    if cache[x][y] > maxSquare {
                        maxSquare = cache[x][y]
                    }
                    continue
                }
                
                let topVal = cache[x][y-1]
                let leftVal = cache[x-1][y]
                let topLeftVal = cache[x-1][y-1]
                
                // Add one bc we traverse to the left and towards bottom
                // (ie. only the original values)
                let localMax = 1 + min(topVal, leftVal, topLeftVal)
                cache[x][y] = localMax
                
                // If the current square is larger than current best
                if localMax > maxSquare {
                    maxSquare = localMax
                }
            }
        }
        
        return maxSquare*maxSquare
    }
}

let matrix: [[Character]] = [["1","0","1","0","0"],
              ["1","0","1","1","1"],
              ["1","1","1","1","1"],
              ["1","0","0","1","0"]]

//let matrix: [[Character]] = [["1"]] //[["1", "1"],["1", "1"],["1", "1"],["1", "1"]]
let sol = Solution().maximalSquare(matrix)
