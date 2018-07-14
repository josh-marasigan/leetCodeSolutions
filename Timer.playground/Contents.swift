import UIKit

class Solution {
    private var count = 0
    var timer: Timer?
    
    func initTimer() {
        timer = Timer.init(timeInterval: 0.05, target: self, selector: #selector(printMsg), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        //.run(until: Date(timeIntervalSinceNow: 10))
        
    }
    
    func fire() {
        timer?.fire()
        print("Fire")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            sol.invalidate()
        }
    }
    
    @objc func printMsg() {
        DispatchQueue.main.async {
            print("Count.. \(self.count)")
            self.count += 1
        }
    }
    
    func invalidate() {
        self.timer?.invalidate()
        self.timer = nil
        print("Invalidated")
    }
}

let sol = Solution()
sol.initTimer()
DispatchQueue.main.async {
    sol.fire()
}
