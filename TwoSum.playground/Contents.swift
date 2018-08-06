import UIKit

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else { return [Int]() }
        
        // Key: Target - Value
        // Val: Index of Value
        var dict = [Int:Int]()
        
        for index in 0 ..< nums.count {
            let inverse = target - nums[index]
            dict[inverse] = index
        }
        
        var indices = [Int]()
        for index in 0 ..< nums.count {
            if let inverseIndex = dict[nums[index]], inverseIndex != index {
                indices.append(index)
                indices.append(inverseIndex)
                break
            }
        }
        
        return indices
    }
}

extension Solution {
    func twoSumPreSorted(_ nums: inout [Int], _ target: Int) -> [Int] {
        
        var indices = [Int]()
        
        // Ensure O(nlog) runtime
        if !self.isSorted(&nums) {
            self.quicksort(&nums, 0, nums.count)
        }
        
        var head = 0
        var tail = nums.count - 1
        
        while head < tail {
            let localSum = nums[head] + nums[tail]
            if localSum > target {
                tail -= 1
            } else if localSum < target {
                head += 1
            } else {
                indices.append(head)
                indices.append(tail)
                break
            }
        }
        
        return indices
    }
    
    // Ensure O(nlogn), check if presorted
    // O(n) time
    private func isSorted(_ nums: inout [Int]) -> Bool {
        guard nums.count > 0 else { return true }
        var head = 0
        var tail = 1
        
        while tail < nums.count {
            if nums[head] > nums[tail] {
                return false
            }
            head += 1
            tail += 1
        }
        
        return true
    }
    
    // Low is initially 0
    // High is initially arr size
    private func quicksort(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let partition: Int = self.findPartition(&nums, low, high - 1)
            self.quicksort(&nums, low, partition - 1)
            self.quicksort(&nums, partition + 1, high)
        }
    }
    
    private func findPartition(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let pivot = nums[high]
        
        var i = low
        for next in low ..< high {
            if nums[next] <= pivot {
                (nums[i], nums[next]) == (nums[next], nums[i])
                i += 1
            }
        }
        
        // 'i' will somtimes equal to 'high', meaning 'high' is already at the right position
        (nums[i], nums[high]) = (nums[high], nums[i])
        return i
    }
}

//let nums = [3,2,4]
//let target = 6
//let sol = Solution().twoSum(nums, target)

var nums = [1,2,3,4,5,6,7] //[3,2,4,1]
let target = 6
let secondSol = Solution().twoSumPreSorted(&nums, target)
