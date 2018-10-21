import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    // Where key is the level for all valid permutations at key-level
    private lazy var cache: [Int : [TreeNode?]] = {
        return [Int : [TreeNode?]]()
    }()
    
    func allPossibleFBT(_ N: Int) -> [TreeNode?] {
        guard (N % 2) != 0 else { return [TreeNode?]() }
        
        if let cachedTree = self.cache[N] {
            return cachedTree
        }
        
        var validTrees = [TreeNode?]()
        
        if N == 1 {
            validTrees.append(TreeNode(0))
            return validTrees
        }
        
        // One level deeper == One node less (the root)
        let nodesLeft = N - 1
        var nodeCount = 1
        while nodeCount < nodesLeft {
            let validLeftNodes = self.allPossibleFBT(nodeCount)
            let validRightNodes = self.allPossibleFBT(nodesLeft - nodeCount)
            
            for leftNode in validLeftNodes {
                for rightNode in validRightNodes {
                    let current = TreeNode(0)
                    current.left = leftNode
                    current.right = rightNode
                    validTrees.append(current)
                }
            }
            
            nodeCount += 2
        }
        
        self.cache[nodesLeft] = validTrees
        return validTrees
    }
    
    func nodeToArr(_ node: TreeNode?) -> [String] {
        var arr = [Int?]()
        preOrder(node, &arr)
        
        var res = [String]()
        for val in arr {
            guard let val = val else {
                res.append("nil")
                continue
            }
            res.append(String(describing: val))
        }
        
        return res
    }
    
    func preOrder(_ node: TreeNode?, _ arr: inout [Int?]) {
        guard let node = node else {
            arr.append(nil)
            return
        }
        arr.append(node.val)
        preOrder(node.left, &arr)
        preOrder(node.right, &arr)
    }
}

let sol = Solution()
let N = 5
let trees = sol.allPossibleFBT(N)

trees.forEach { (tree) in
    print(sol.nodeToArr(tree))
}

