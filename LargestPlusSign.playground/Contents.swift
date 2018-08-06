import UIKit

class Solution {
    func orderOfLargestPlusSign(_ N: Int, _ mines: [[Int]]) -> Int {
        guard N > 0 else { return 0 }
        
        // O(row x col) : Runtime
        // O(row x col) : Space
        // Fill cache with NxN grid full of 'N' values
        var cache: [[Int]] = Array(repeating: Array(repeating: N, count: N), count: N)
        
        // O( < N ) so O(row x col) runtime will supersede this. Or simply O(5000)/O(C)
        for mine in mines {
            let mineX = mine[0]
            let mineY = mine[1]
            cache[mineX][mineY] = 0
        }
        
        // O(row x col) : Runtime
        for x in 0 ..< N {
            var y = 0
            var y2 = N-1
            
            var leftCount = 0
            var rightCount = 0
            var topCount = 0
            var bottomCount = 0
            
            // O(N) but going from both edges. 4 Operations w/ 2 varying indices
            while y < N {
                // O(4) access -> O(C)
                leftCount = cache[x][y] != 0 ? leftCount + 1 : 0
                rightCount = cache[x][y2] != 0 ? rightCount + 1 : 0
                topCount = cache[y][x] != 0 ? topCount + 1 : 0
                bottomCount = cache[y2][x] != 0 ? bottomCount + 1 : 0
                
                // Replace 'N' or old valued indeces w/ the current ascension count for that direction
                cache[x][y] = min(cache[x][y], leftCount)
                cache[x][y2] = min(cache[x][y2], rightCount)
                cache[y][x] = min(cache[y][x], topCount)
                cache[y2][x] = min(cache[y2][x], bottomCount)

                y += 1
                y2 -= 1
            }
        }
        
        // Get largest order
        var largestOrder = 0
        for row in cache {
            let localMax = row.reduce(Int.min, { max($0, $1) })
            if localMax > largestOrder {
                largestOrder = localMax
            }
        }
        
        // Summary
        // Runtime: O(N*2)
        // Space: O(row x col)
        return largestOrder
    }
}

let N = 2
let mines = [[0,0],[0,1],[1,0]] // [[3,0],[3,3]] //[[4,2]]
let sol = Solution().orderOfLargestPlusSign(N, mines)
