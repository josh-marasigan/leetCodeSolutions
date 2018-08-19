
// Return minimum # of steps to get to the end
class Solution {
    enum TowerHopperError: Error {
        case InvalidInput
    }
    
    struct Queue<Int> {
        var queue = [Int]()
        var startIndex = 0
        
        mutating func enqueue(_ val: Int) {
            self.queue.append(val)
        }
        
        mutating func dequeue() -> Int? {
            guard queue.count > 0, startIndex < queue.count else {
                return nil
            }
            
            startIndex += 1
            return queue[startIndex - 1]
        }
    }
    
    func towerHopperBFS(_ towers: inout [Int]) throws -> Int {
        guard towers.count > 0, towers[0] > 0 else {
            throw TowerHopperError.InvalidInput
        }
        
        // Key: Index of tower
        // Val: If visited
        var visited = [Int:Bool]()
        visited[0] = true
        
        var queue = Queue<Int>()
        queue.enqueue(0)
        
        var jumps = 0
        while let current = queue.dequeue() {
            visited[current] = true
            
            let nextTower = self.getHighestPotentialNeighbor(&towers, current)
            
            // Base case: Found
            if nextTower == Int.max {
                jumps += 1
                break
            }
            
            if let _ = visited[nextTower] {
                continue
            }
            
            jumps += 1
            queue.enqueue(nextTower)
        }
        
        return jumps
    }
    
    // Returns list of indexes representing neighbors
    func getHighestPotentialNeighbor(_ towers: inout [Int], _ current: Int) -> Int {
        let steps = towers[current]
        
        var nextTower = current
        var globalMax = 0
        for index in current + 1 ... current + steps {
            if index > towers.count - 1 {
                return Int.max
            }
            
            if towers[index] > 0 {
                let localMax = towers[index] + index
                if localMax >= globalMax {
                    // Previously tall tower need not be visited next iteration
                    towers[nextTower] = 0
                    
                    globalMax = localMax
                    nextTower = index
                }
            }
        }
        
        return nextTower
    }
}

//let towers = [4,2,0,0,9,0,0,0,0,0,0,0,0]
var towers = [2,1]
let sol = try Solution().towerHopperBFS(&towers)
print("Number of hops: \(sol)")

