import UIKit

class Solution {
    
    // topViewArea : (x,y) -> Area is the # of nonzero indices (Top View)
    // sideViewArea : (x,z) -> Area is the total of the max height of each row (Front View)
    // frontViewArea : (z,y) -> Area is the total of the max height of each column (Side View)
    func projectionArea(_ grid: [[Int]]) -> Int {
        guard grid.count > 0, grid[0].count > 0 else { return 0 }
        
        var topViewArea = 0
        var sideViewArea = 0
        var frontViewArea = 0
        for x in 0 ..< grid.count {
            var localSideViewMax = 0
            var localFrontViewMax = 0
            
            for y in 0 ..< grid[0].count {
                if grid[x][y] > localSideViewMax {
                    localSideViewMax = grid[x][y]
                }
                
                if grid[y][x] > localFrontViewMax {
                    localFrontViewMax = grid[y][x]
                }
                
                if y >= x, grid[x][y] != 0 {
                    topViewArea += 1
                }
                
                if y >= x, grid[y][x] != 0, x != y {
                    topViewArea += 1
                }
            }
            
            sideViewArea += localSideViewMax
            frontViewArea += localFrontViewMax
        }
        
        // Runtime: O(n^2) -> n == grid.length
        // Space: O(1)
        return topViewArea + sideViewArea + frontViewArea
    }
}

//let grid = [[1,4],[1,1]] // [[1,1,1],[1,0,1],[1,1,1]] //[[1,2],[3,4]]
//let grid = [[2,2,2],[2,1,2],[2,2,2]]
let grid = [[1,0],[0,2]]
let sol = Solution().projectionArea(grid)
