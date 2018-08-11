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

// Coordinate Struct for DFS
class GraphSearch {
    struct Coordinate: Hashable {
        var x: Int
        var y: Int

        init(x: Int, y: Int, _ parent: (x: Int, y: Int)? = nil) {
            self.x = x
            self.y = y
        }
        
        var hashValue: Int {
            return (x.hashValue ^ y.hashValue) &* 16777619
        }
        
        static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }

    /* Check edges. Need 'node.x - 1' bc we're looking to be one node before the x edge to avoid pointing outside of graph */
    private func getNeighbors(_ graph: inout [[Int]], _ node: Coordinate) -> [Coordinate] {
        var neighbors = [Coordinate]()

        if node.x > 0 {
            let leftChild = Coordinate(x: node.x - 1, y: node.y)
            neighbors.append(leftChild)
        }
        if node.x < graph.count - 1 {
            let rightChild = Coordinate(x: node.x + 1, y: node.y)
            neighbors.append(rightChild)
        }
        if node.y > 0 {
            let bottomChild = Coordinate(x: node.x, y: node.y - 1)
            neighbors.append(bottomChild)
        }
        if node.y < graph[node.x].count - 1 {
            let topChild = Coordinate(x: node.x, y: node.y + 1)
            neighbors.append(topChild)
        }

        return neighbors
    }
}

// Coordinate Class for BFS
extension GraphSearch {
    class BFSCoordinate: Hashable {
        var x: Int
        var y: Int
        var parent: BFSCoordinate?

        init(x: Int, y: Int, parent: BFSCoordinate?) {
            self.x = x
            self.y = y
            self.parent = parent
        }

        var hashValue: Int {
            return Int("(\(x)\(y))") ?? 0
        }

        static func == (lhs: BFSCoordinate, rhs: BFSCoordinate) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }

    private func getNeighborsBFS(_ graph: inout [[Int]], _ node: BFSCoordinate) -> [BFSCoordinate] {
        var neighbors = [BFSCoordinate]()

        if node.x > 0 {
            let leftChild = BFSCoordinate(x: node.x - 1, y: node.y, parent: node)
            neighbors.append(leftChild)
        }
        if node.x < graph.count - 1 {
            let rightChild = BFSCoordinate(x: node.x + 1, y: node.y, parent: node)
            neighbors.append(rightChild)
        }
        if node.y > 0 {
            let bottomChild = BFSCoordinate(x: node.x, y: node.y - 1, parent: node)
            neighbors.append(bottomChild)
        }
        if node.y < graph[node.x].count - 1 {
            let topChild = BFSCoordinate(x: node.x, y: node.y + 1, parent: node)
            neighbors.append(topChild)
        }

        return neighbors
    }
}

// Breadth First Search
extension GraphSearch {
    // TEMP
    // In: Graph, Source, Target
    // Out: Shortest Path
    func breadthFirstSearch(_ graph: inout [[Int]], source: [Int], target: Int) -> [[Int]] {
        var shortestPath = [[Int]]()
        
        let start = BFSCoordinate(x: source[0], y: source[1], parent: nil)

        var queue = Queue<BFSCoordinate>()
        queue.enqueue(start)

        var nodesExplored = [BFSCoordinate:Bool]()
        nodesExplored[start] = true

        while let node = queue.dequeue() {
            if graph[node.x][node.y] == target {
                print("Found Node at [\(node.x),\(node.y)]")
                shortestPath = self.printSearchTree(node: node)
                break
            }

            for neighbor in self.getNeighborsBFS(&graph, node) {
                if let _ = nodesExplored[neighbor] {
                    continue
                }

                queue.enqueue(neighbor)
                nodesExplored[neighbor] = true
            }
        }

        print("BFS Done.")
        return shortestPath
    }

    // Helper to print shortes path
    private func printSearchTree(node: BFSCoordinate) -> [[Int]] {
        var shortestPath = [[Int]]()
        
        shortestPath.append([node.x, node.y])
        
        var node = node
        while let current = node.parent {
            print("[\(current.x),\(current.y)]")

            // If not the origin
            shortestPath.append([current.x, current.y])
            node = current
        }
        
        // Remove origin from count
        shortestPath.removeLast()
        return shortestPath
    }
}

// Depth First Search Iterative
extension GraphSearch {

    func depthFirstSearchIterative(_ graph: inout [[Int]], source: [Int], target: Int) {
        var path = [Coordinate]()

        let start = Coordinate(x: source[0], y: source[1])

        var stack = Stack<Coordinate>()
        stack.push(start)

        var visitedNodes = [Coordinate:Bool]()
        visitedNodes[start] = true

        outer: while let node = stack.peek() {
            path.append(node)

            if graph[node.x][node.y] == target {
                print("Found Node at [\(node.x),\(node.y)]")
                break
            }

            let children = self.getNeighbors(&graph, node)
            if children.isEmpty {
                stack.pop()
                continue
            }

            for child in children {
                if let _ = visitedNodes[child] {
                    continue
                }

                visitedNodes[child] = true
                stack.push(child)

                continue outer
            }

            stack.pop()
        }

        print("Iterative DFS Done. Search Tree: ")
        for (_, value) in path.enumerated() {
            print("Node at: [\(value.x),\(value.y)]")
        }
    }
}

// Depth First Search Recursive
extension GraphSearch {

    func depthFirstSearchRecursive(_ graph: inout [[Int]], source: [Int], target: Int) {
        let source = Coordinate(x: source[0], y: source[1])

        var visitedNodes = [Coordinate:Bool]()
        visitedNodes[source] = true

        self.dfsRecursiveUtil(&visitedNodes, &graph, source: source, target: target)
    }

    // Recurse with each child being a source
    private func dfsRecursiveUtil(
        _ visited: inout [Coordinate:Bool],
        _ graph: inout [[Int]],
        source: Coordinate,
        target: Int
        ) -> Coordinate? {

        if graph[source.x][source.y] == target {
            print("Found Node at [\(source.x),\(source.y)]")
            return source
        }

        let neighbors = self.getNeighbors(&graph, source)

        if neighbors.count == 0 {
            return nil
        }

        for child in neighbors {
            if let _ = visited[child] {
                continue
            }

            visited[child] = true

            if let foundNode = self.dfsRecursiveUtil(&visited, &graph, source: child, target: target) {
                return foundNode
            }
        }

        // Target has not been found. Return with nil, indicating value not existing
        return nil
    }
}

let graphSearch = GraphSearch()
var graph =
[
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,1],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0]
]

// BFS
//graphSearch.breadthFirstSearch(&graph, source: [0,0], target: -1)

// DFS Iterative
//graphSearch.depthFirstSearchIterative(&graph, source: [0,0], target: -1)

// DFS Recursice
//graphSearch.depthFirstSearchRecursive(&graph, source: [0,0], target: -1)

//Solution().numIslands([["1","1","1","1","0"],["1","1","0","1","0"],["1","1","0","0","0"],["0","0","0","0","0"]])

let shortestPath = GraphSearch().breadthFirstSearch(&graph, source: [0,0], target: 1)

// Visualize shortest path
for node in shortestPath {
    graph[node[0]][node[1]] = 1
}

var count = 0
if let targetCoordinate = shortestPath.first {
    count += (targetCoordinate[0] + targetCoordinate[1])
}
print("Shortest Path Count From Target: \(count)")
print("Shortest Path Count: \(shortestPath.count)")
print("Shortest Path Visualized - ")
for row in graph {
    print(row)
}


