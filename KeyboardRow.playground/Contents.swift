import UIKit

class Solution {
    func findWords(_ words: [String]) -> [String] {
        guard words.count > 0 else { return [String]() }
        
        // O(26*2 / 3) Space complexity -> O(1)
        var characterDict = [Character : String]()
        for c in "QWERTYUIOPqwertyuiop" { characterDict[c] = "tabRow" }
        for c in "ASDFGHJKLasdfghjkl" { characterDict[c] = "capsRow" }
        for c in "ZXCVBNMzxcvbnm" { characterDict[c] = "shiftRow" }
        
        var validWords = [String]()
        outer: for word in words {
            
            // We use last bc 'last' is a O(1) operation,
            // while first is O(n) in swift
            guard let lastChar = word.last,
                let lastCharGroup = characterDict[lastChar] else { continue }
            
            for char in word {
                guard let charGroup = characterDict[char] else {
                    continue outer
                }
                
                if charGroup != lastCharGroup {
                    continue outer
                }
            }
            
            validWords.append(word)
        }
        
        return validWords
    }
}

let words = ["Hello", "Alaska", "Dad", "Peace"]
let sol = Solution().findWords(words)
