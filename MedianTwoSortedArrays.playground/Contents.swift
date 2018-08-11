import UIKit

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        let short = (nums1.count >= nums2.count) ? nums2 : nums1
        let long = (nums2.count > nums1.count) ? nums2 : nums1
        
        let shortCount = short.count
        let longCount = long.count
        
        var low = 0
        var high = shortCount
        
        var median = Double()
        while low <= high {
            
            let partitionLow = (low + high)/2
            let partitionHigh = (shortCount + longCount + 1) / 2 - partitionLow
            
            let maxLeftLow = partitionLow != 0 ? short[partitionLow - 1] : Int.min
            let minRightLow = partitionLow != shortCount ? short[partitionLow] : Int.max
            
            let maxLeftHigh = partitionHigh != 0 ? long[partitionHigh - 1] : Int.min
            let minRightHigh = partitionHigh != longCount ? long[partitionHigh] : Int.max
            
            if maxLeftLow <= minRightHigh, maxLeftHigh <= minRightLow {
                
                let isOdd = (shortCount + longCount) % 2 != 0
                median = isOdd ?
                    Double(max(maxLeftLow, maxLeftHigh)) :
                    Double(max(maxLeftLow, maxLeftHigh) + min(minRightLow, minRightHigh)) / 2
                
                break
            }
                
            else if maxLeftLow > minRightHigh {
                high = partitionLow - 1
            } else {
                low = partitionLow + 1
            }
        }
        
        return median
    }
}

let nums1 = [1,2] //[1,3,8,9,15] //[1,3]
let nums2 = [3,4] //[7,11,18,19,21,25] //[2]

let sol = Solution().findMedianSortedArrays(nums1, nums2)
