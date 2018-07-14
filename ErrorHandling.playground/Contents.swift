import Foundation

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
        print(result)
        return result
    }
    
    private func dfs(_ digits: inout [Int], _ digitIndex: Int, _ permutation: inout [Int]) {
        // Base Case, valid format -> can start checking for next time
        if digitIndex == 4  {
            let hour = permutation[0] * 10 + permutation[1]
            let min = permutation[2] * 10 + permutation[3]
            if (0..<24 ~= hour) && (0..<60 ~= min) {
                let timeDifference = self.getTimeDifference(hour, min)
                if timeDifference != 0, timeDifference < closestTime {
                    closestTime = timeDifference
                    let hourString = permutation[0] == 0 ? "0\(hour)" : "\(hour)"
                    let minString = permutation[2] == 0 ? "0\(min)" : "\(min)"
                    result = hourString + ":" + minString
                }
            }
        }
        
        // Recurse
        else {
            for index in 0..<4 {
                permutation[digitIndex] = digits[index]
                self.dfs(&digits, digitIndex + 1, &permutation)
            }
        }
    }
    
    private func getTimeDifference(_ hour: Int, _ min: Int) -> Int {
        let givenTimeMinTotal = (hoursGiven * 60) + minsGiven
        let permutationTotal = (hour * 60) + min
        
        // In the past, go to next day
        if permutationTotal < givenTimeMinTotal {
            return (permutationTotal + 24*60) - givenTimeMinTotal
        }
        return permutationTotal - givenTimeMinTotal
    }
}

Solution().nextClosestTime("00:00")
