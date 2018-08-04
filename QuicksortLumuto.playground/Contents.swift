import UIKit

class Solution {
    func quicksort(_ nums: inout [Int], _ low: Int, _ high: Int) {
        if low < high {
            let part = partition(&nums, low, high-1)
            quicksort(&nums, low, part - 1)
            quicksort(&nums, part + 1, high)
            
        }
    }

    private func partition(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
        let pivot = nums[high]
        
        var i = low
        for next in low ..< high {
            if nums[next] <= pivot {
                (nums[i], nums[next]) = (nums[next], nums[i])
                i += 1
            }
        }
        
        (nums[i], nums[high]) = (nums[high], nums[i])
        return i
    }
}

var a = [10,1,9,2,8,3,7,4,6,5]
Solution().quicksort(&a, 0, a.count)

let x = Int.max
let y = Int.max

let z = x + (y-x)/2
