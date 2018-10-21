import UIKit

class Solution {
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
    
    func tree2str(_ t: TreeNode?) -> String {
        guard let t = t else { return "" }
        
        return tree2strUtil(t)
    }
    
    func tree2strUtil(_ t: TreeNode?) -> String {
        guard let t = t else { return "()" }
        
        var out = ""
        out.append(String(describing: t.val))
        
        let leftSubtree = tree2strUtil(t.left)
        let rightSubtree = tree2strUtil(t.right)
        
        if leftSubtree == "()" && rightSubtree == "()" {
            return out
        }
        
        var childOut = ""
        if leftSubtree == "()" {
            childOut = "\(leftSubtree)(\(rightSubtree))"
        }
        else if rightSubtree == "()" {
            childOut = "(\(leftSubtree))"
        } else {
            childOut = "(\(leftSubtree))(\(rightSubtree))"
        }
        
        out.append("\(childOut)")
        return out
    }
}
