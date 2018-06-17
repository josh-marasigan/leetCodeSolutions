import UIKit
import Foundation

class Solution {
    private typealias CharacterIndex = (x: Int, y: Int, flatIndex: String)
    
    func numIslands(_ grid: [[Character]]) -> Int {
        
        // Track nodes (CharacterIndex) if visited (Bool)
        var visitedNodesMap = [String:Bool]()
        var totalIslands = 0
        
        // O(# of nodes total). Only runs once.
        for x in 0..<grid.count {
            for y in 0..<grid[x].count {
                visitedNodesMap["\(x)\(y)"] = false
            }
        }
        
        // Perform a Breadth First Search at each unvisited '1' cell to see this island has not been visited.
        for x in 0..<grid.count {
            for y in 0..<grid[x].count {
                
                // Given index is not on land
                if grid[x][y] == "0" { continue }
                
                // Use flatIndex to check visitedNodesMap
                if let nodeVisited = visitedNodesMap["\(x)\(y)"], !nodeVisited {
                    visitedNodesMap = self.islandBreadthFirstSearch(grid, (x: x, y: y, flatIndex: "\(x)\(y)"),
                                                                    visitedNodesMap: visitedNodesMap)
                    totalIslands = totalIslands + 1
                    print("Island Count.... \(totalIslands)")
                }
            }
        }
        
        return totalIslands
    }
    
    /*
     Input: The island and the index pair currently being checked
     Output: Returns nodes visited in search.
     */
    private func islandBreadthFirstSearch(_ grid: [[Character]],
                                          _ rootIndex: CharacterIndex,
                                          visitedNodesMap: [String:Bool]) -> [String:Bool] {
        
        // Mutable array of unvisited node indexes
        var unvisitedNodes = [CharacterIndex]()
        
        // Track nodes (CharacterIndex) if visited (Bool)
        var visitedNodesMap: [String:Bool] = visitedNodesMap

        // Start with the root
        unvisitedNodes.append(rootIndex)
        visitedNodesMap["\(rootIndex.x)\(rootIndex.y)"] = true
        
        // O(# number of nodes) runtime
        while !unvisitedNodes.isEmpty {
            
            // O(# of unvisited nodes) runtime
            let current = unvisitedNodes.removeFirst()
            
            // Get neighbors
            var neighbors = [CharacterIndex]()
            neighbors.append((x: current.x-1, y: current.y, flatIndex: "\(current.x-1)\(current.y)"))
            neighbors.append((x: current.x+1, y: current.y, flatIndex: "\(current.x+1)\(current.y)"))
            neighbors.append((x: current.x, y: current.y-1, flatIndex: "\(current.x)\(current.y-1)"))
            neighbors.append((x: current.x, y: current.y+1, flatIndex: "\(current.x)\(current.y+1)"))
            
            // Check if neighboring nodes are in bounds, has not been visited, and if on land
            for neighbor in neighbors {
                guard let nodeVisited = visitedNodesMap["\(neighbor.x)\(neighbor.y)"] else { continue }
                
                if self.withinBounds(grid, nodeIndex: neighbor), !nodeVisited, grid[neighbor.x][neighbor.y] == "1" {
                    unvisitedNodes.append(neighbor)
                    visitedNodesMap["\(neighbor.x)\(neighbor.y)"] = true
                }
            }
        }
        
        return visitedNodesMap
    }
    
    private func withinBounds(_ grid: [[Character]], nodeIndex: CharacterIndex) -> Bool {
        return (0..<grid.count ~= nodeIndex.x) && (0..<grid[nodeIndex.x].count ~= nodeIndex.y)
    }
}

let solution = Solution()
let numberOfIslands = solution.numIslands(
            [["1","0","0","1","1","1","0","1","1","0","0","0","0","0","0","0","0","0","0","0"],
             ["1","0","0","1","1","0","0","1","0","0","0","1","0","1","0","1","0","0","1","0"],
             ["0","0","0","1","1","1","1","0","1","0","1","1","0","0","0","0","1","0","1","0"],
             ["0","0","0","1","1","0","0","1","0","0","0","1","1","1","0","0","1","0","0","1"],
             ["0","0","0","0","0","0","0","1","1","1","0","0","0","0","0","0","0","0","0","0"],
             ["1","0","0","0","0","1","0","1","0","1","1","0","0","0","0","0","0","1","0","1"],
             ["0","0","0","1","0","0","0","1","0","1","0","1","0","1","0","1","0","1","0","1"],
             ["0","0","0","1","0","1","0","0","1","1","0","1","0","1","1","0","1","1","1","0"],
             ["0","0","0","0","1","0","0","1","1","0","0","0","0","1","0","0","0","1","0","1"],
             ["0","0","1","0","0","1","0","0","0","0","0","1","0","0","1","0","0","0","1","0"],
             ["1","0","0","1","0","0","0","0","0","0","0","1","0","0","1","0","1","0","1","0"],
             ["0","1","0","0","0","1","0","1","0","1","1","0","1","1","1","0","1","1","0","0"],
             ["1","1","0","1","0","0","0","0","1","0","0","0","0","0","0","1","0","0","0","1"],
             ["0","1","0","0","1","1","1","0","0","0","1","1","1","1","1","0","1","0","0","0"],
             ["0","0","1","1","1","0","0","0","1","1","0","0","0","1","0","1","0","0","0","0"],
             ["1","0","0","1","0","1","0","0","0","0","1","0","0","0","1","0","1","0","1","1"],
             ["1","0","1","0","0","0","0","0","0","1","0","0","0","1","0","1","0","0","0","0"],
             ["0","1","1","0","0","0","1","1","1","0","1","0","1","0","1","1","1","1","0","0"],
             ["0","1","0","0","0","0","1","1","0","0","1","0","1","0","0","1","0","0","1","1"],
             ["0","0","0","0","0","0","1","1","1","1","0","1","0","0","0","1","1","0","0","0"]]
            )

print("""
[["1","0","0","1","1","1","0","1","1","0","0","0","0","0","0","0","0","0","0","0"],["1","0","0","1","1","0","0","1","0","0","0","1","0","1","0","1","0","0","1","0"],["0","0","0","1","1","1","1","0","1","0","1","1","0","0","0","0","1","0","1","0"],["0","0","0","1","1","0","0","1","0","0","0","1","1","1","0","0","1","0","0","1"],["0","0","0","0","0","0","0","1","1","1","0","0","0","0","0","0","0","0","0","0"],["1","0","0","0","0","1","0","1","0","1","1","0","0","0","0","0","0","1","0","1"],["0","0","0","1","0","0","0","1","0","1","0","1","0","1","0","1","0","1","0","1"],["0","0","0","1","0","1","0","0","1","1","0","1","0","1","1","0","1","1","1","0"],["0","0","0","0","1","0","0","1","1","0","0","0","0","1","0","0","0","1","0","1"],["0","0","1","0","0","1","0","0","0","0","0","1","0","0","1","0","0","0","1","0"],["1","0","0","1","0","0","0","0","0","0","0","1","0","0","1","0","1","0","1","0"],["0","1","0","0","0","1","0","1","0","1","1","0","1","1","1","0","1","1","0","0"],["1","1","0","1","0","0","0","0","1","0","0","0","0","0","0","1","0","0","0","1"],["0","1","0","0","1","1","1","0","0","0","1","1","1","1","1","0","1","0","0","0"],["0","0","1","1","1","0","0","0","1","1","0","0","0","1","0","1","0","0","0","0"],["1","0","0","1","0","1","0","0","0","0","1","0","0","0","1","0","1","0","1","1"],["1","0","1","0","0","0","0","0","0","1","0","0","0","1","0","1","0","0","0","0"],["0","1","1","0","0","0","1","1","1","0","1","0","1","0","1","1","1","1","0","0"],["0","1","0","0","0","0","1","1","0","0","1","0","1","0","0","1","0","0","1","1"],["0","0","0","0","0","0","1","1","1","1","0","1","0","0","0","1","1","0","0","0"]]
""")

print("# of Islands: " + String(describing:numberOfIslands))
