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
    private var firstMisplaced: TreeNode? = nil
    private var secondMisplaced: TreeNode? = nil
    private var previous: TreeNode? = TreeNode(Int.min)
    
    func recoverTree(_ root: TreeNode?) {
        guard let root = root else { return }
        
        self.inOrderTraversal(root)
        
        guard let firstVal = firstMisplaced?.val, let secondVal = secondMisplaced?.val else {
            return
        }
        
        self.firstMisplaced?.val = secondVal
        self.secondMisplaced?.val = firstVal
    }
    
    private func inOrderTraversal(_ node: TreeNode?) {
        guard let node = node else { return }
        
        self.inOrderTraversal(node.left)
        
        // Prev bc we anticipate prev being the misplaced val (greater than)
        if firstMisplaced == nil {
            if let previous = previous, previous.val >= node.val {
                firstMisplaced = previous
            }
        }
        
        // Node bc we anticipate node being the misplaced val (less than)
        if let _ = firstMisplaced, let previous = previous, previous.val >= node.val {
            secondMisplaced = node
        }
        self.previous = node
        
        self.inOrderTraversal(node.right)
    }
}

Solution().recoverTree(nil)
