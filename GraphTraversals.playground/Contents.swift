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
            return Int("(\(x)\(y))") ?? 0
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

    func breadthFirstSearch(_ graph: inout [[Int]], source: [Int], target: Int) {
        // Set up source node
        let start = BFSCoordinate(x: source[0], y: source[1], parent: nil)

        // Queue of Nodes to explore
        var queue = Queue<BFSCoordinate>()
        queue.enqueue(start)

        // Queue of Nodes to be explored
        var nodesExplored = [BFSCoordinate:Bool]()
        nodesExplored[start] = true

        while let node = queue.dequeue() {

            // Visit Node
            if graph[node.x][node.y] == target {
                print("Found Node at [\(node.x),\(node.y)]")
                self.printSearchTree(node: node)
                break
            }

            // Add children to queue if not visited
            for neighbor in self.getNeighborsBFS(&graph, node) {

                // Has visited this node already
                if let _ = nodesExplored[neighbor] {
                    continue
                }

                // Add child to visit queue and set as visited
                queue.enqueue(neighbor)
                nodesExplored[neighbor] = true
            }
        }

        // Finished Running BFS. Print Path
        print("BFS Done.")
    }

    // Helper to print shortes path
    private func printSearchTree(node: BFSCoordinate) {
        print("Shortest Path...")

        var node = node
        while let parent = node.parent {
            print("[\(parent.x),\(parent.y)]")
            node = parent
        }
    }
}

// Depth First Search Iterative
extension GraphSearch {

    func depthFirstSearchIterative(_ graph: inout [[Int]], source: [Int], target: Int) {
        var path = [Coordinate]()

        // Set up source node
        let start = Coordinate(x: source[0], y: source[1])

        // Stack of nodes to explore
        var stack = Stack<Coordinate>()
        stack.push(start)

        // Track visited nodes. Set start node as visited
        var visitedNodes = [Coordinate:Bool]()
        visitedNodes[start] = true

        // Iterate through nodes to visit. With a child/neighbor first approach.
        outer: while let node = stack.peek() {
            path.append(node)

            // Visit Node
            if graph[node.x][node.y] == target {
                print("Found Node at [\(node.x),\(node.y)]")
                break
            }

            // If current node has no children, pop the stack to move on to the next node
            let children = self.getNeighbors(&graph, node)
            if children.isEmpty {
                // Dead-end. Backtrack
                stack.pop()
                continue
            }

            // Visit the current node's children
            for child in children {

                // Have already visited this child
                if let _ = visitedNodes[child] {
                    continue
                }

                // Not yet visited. Mark as so.
                visitedNodes[child] = true
                stack.push(child)

                // Break to the outer loop to search the child node we just pushed
                // We need to do this so we can always search child first instead of neighbors

                // By continuing to the outer loop we search this child's children
                // Later we will pop the current node in the stack, thus returning back to this loop
                continue outer
            }

            // All of this nodes edges have been visited.
            // Backtrack from current vertex.
            stack.pop()
        }

        // Finished Running BFS. Print Path
        print("Iterative DFS Done. Search Tree: ")
        for (_, value) in path.enumerated() {
            print("Node at: [\(value.x),\(value.y)]")
        }
    }
}

// Depth First Search Recursive
extension GraphSearch {

    func depthFirstSearchRecursive(_ graph: inout [[Int]], source: [Int], target: Int) {
        // Set up source node
        let source = Coordinate(x: source[0], y: source[1])

        // Track Nodes visited. Mark source node as visited.
        var visitedNodes = [Coordinate:Bool]()
        visitedNodes[source] = true

        // Search through graph via recursive DFS
        self.dfsRecursiveUtil(&visitedNodes, &graph, source: source, target: target)
    }

    // Recurse with each child being a source
    private func dfsRecursiveUtil(
        _ visited: inout [Coordinate:Bool],
        _ graph: inout [[Int]],
        source: Coordinate,
        target: Int
        ) -> Coordinate? {

        // Base Case: Found target -> Return with value
        if graph[source.x][source.y] == target {
            print("Found Node at [\(source.x),\(source.y)]")
            return source
        }

        // Get neighbors
        let neighbors = self.getNeighbors(&graph, source)

        // Base Case: No neighbors -> backtrack
        if neighbors.count == 0 {
            return nil
        }

        // Search children nodes
        for child in neighbors {
            // This node has already been visited. Move to next
            if let _ = visited[child] {
                continue
            }

            // Mark child as visited
            visited[child] = true

            // Recurse by using this child node as a source
            // Searces children first, then neighbors
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
    [0,1,2,3,4,2,1,2,3,7],
    [9,3,1,5,2,3,5,6,2,1],
    [8,3,4,1,5,3,6,9,3,1],
    [0,2,4,1,3,4,2,3,4,4],
    [6,2,4,3,6,4,2,5,5,2],
    [7,8,5,3,6,4,3,5,6,1],
    [5,6,2,8,2,4,9,2,4,-1],
    [0,1,2,3,4,2,1,2,3,7],
    [9,3,1,5,2,3,5,6,2,1],
    [8,3,4,1,5,3,6,9,3,1]
]

// BFS
//graphSearch.breadthFirstSearch(&graph, source: [0,0], target: -1)

// DFS Iterative
//graphSearch.depthFirstSearchIterative(&graph, source: [0,0], target: -1)

// DFS Recursice
//graphSearch.depthFirstSearchRecursive(&graph, source: [0,0], target: -1)

//Solution().numIslands([["1","1","1","1","0"],["1","1","0","1","0"],["1","1","0","0","0"],["0","0","0","0","0"]])

