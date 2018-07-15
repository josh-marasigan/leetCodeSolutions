import UIKit

class Solution {
    
    private var result: String = ""
    private var closestTime: Int = Int(UInt16.max)
    private var hoursGiven: Int = 0
    private var minsGiven: Int = 0
    
    func nextClosestTime(_ time: String) -> String {
        var stringDigits = time.split { $0 == ":" }
        var digits: [Int] = [0,0,0,0]
        
        hoursGiven = Int(String(stringDigits[0]))!
        minsGiven = Int(String(stringDigits[1]))!
        
        digits[0] = hoursGiven / 10
        digits[1] = hoursGiven % 10
        digits[2] = minsGiven / 10
        digits[3] = minsGiven % 10
        
        var permutation: [Int] = [0,0,0,0]
        self.dfs(&digits, 0, &permutation)
        
        // if non-unique digits, can't have a time difference so return original
        return (result == "") ? time : result
    }
    
    private func dfs(_ digits: inout [Int], _ digitIndex: Int, _ permutation: inout [Int]) {
        
        // Base Case, valid format -> can start checking for next time
        if digitIndex == 4  {
            let hour = permutation[0] * 10 + permutation[1]
            let min = permutation[2] * 10 + permutation[3]
            let timeDifference = self.getTimeDifference(hour, min)
            
            if timeDifference != 0, timeDifference < closestTime {
                closestTime = timeDifference
                
                let hourString = permutation[0] == 0 ? "0\(hour)" : "\(hour)"
                let minString = permutation[2] == 0 ? "0\(min)" : "\(min)"
                result = hourString + ":" + minString
            }
        }
        else {
            // Recurse
            for index in 0..<digits.count {
                
                // Add new permutation for this 'digitIndex'. This 'digitIndex' will permute w/
                // all values in digits
                permutation[digitIndex] = digits[index]
                
                // Last Hour index -> Prune hours
                if digitIndex == 1 {
                    let hour = permutation[0] * 10 + permutation[1]
                    if 0..<24 ~= hour { self.dfs(&digits, digitIndex + 1, &permutation) }
                    
                // Last Minute index -> Prune mins
                } else if digitIndex == 3 {
                    let mins = permutation[2] * 10 + permutation[3]
                    if 0..<60 ~= mins { self.dfs(&digits, digitIndex + 1, &permutation) }
                    
                } else {
                    self.dfs(&digits, digitIndex + 1, &permutation)
                }
            }
        }
    }
    
    private func getTimeDifference(_ hour: Int, _ min: Int) -> Int {
        let givenTimeMinTotal = (hoursGiven * 60) + minsGiven
        let permutationTotal = (hour * 60) + min
        
        // In the past, go to next day
        if permutationTotal < givenTimeMinTotal {
            let hoursInDay = 24*60
            return (permutationTotal + hoursInDay) - givenTimeMinTotal
        }
        return permutationTotal - givenTimeMinTotal
    }
}

Solution().nextClosestTime("19:34")
