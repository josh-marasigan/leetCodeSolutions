import UIKit

class Solution {
    func countBits(_ num: Int) -> [Int] {
        guard num > 0 else { return [0] }
        
        var results = Array(repeating: 0, count: num + 1)
        results[0] = 0
        
        var bitCount = 1
        for n in 1 ... num {
            if bitCount * 2 == n {
                // Reserve more bits for the next integer
                bitCount = bitCount * 2
            }
            
            results[n] = results[n - bitCount] + 1
        }
        
        return results
    }
}

extension Solution {
    func countingBitsDP(_ num: Int) -> [Int] {
        var bitCount = Array(repeating: 0, count: num + 1)
        bitCount[0] = 0
        
        for n in 1 ... num {
            // Get previous bitCount before this recent bit
            // ie. 4 is '1000' but is just an extra '0'
            // bit from 2 which is '100'
            bitCount[n] = bitCount[n/2]
            
            // If this n is negative, increment the bitcount
            if n % 2 > 0 {
                bitCount[n] += 1
            }
        }
        
        return bitCount
    }
}

let sol = Solution().countBits(5)
let sol2 = Solution().countingBitsDP(5)
