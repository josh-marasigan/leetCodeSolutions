import UIKit

// MARK: - Trie Solution
class Solution {
    class TrieNode<Character : Hashable> {
        
        weak var parent: TrieNode?
        var children: [Character: TrieNode] = [:]
        
        var value: Character?
        var isTerminating = false
        
        init(value: Character? = nil, parent: TrieNode? = nil) {
            self.value = value
            self.parent = parent
        }
        
        func add(child: Character) {
            guard children[child] == nil else { return }
            children[child] = TrieNode(value: child, parent: self)
        }
    }
    
    class Trie {
        typealias Node = TrieNode<Character>
        fileprivate let root: Node
        
        init() {
            root = Node()
        }
        
        func insert(word: String) {
            
            guard !word.isEmpty else { return }
            
            var currentNode = root
            
            let characters = Array<Character>(word.lowercased())
            
            var currentIndex = 0
            while currentIndex < characters.count {
                
                let character = characters[currentIndex]
                if let child = currentNode.children[character] {
                    currentNode = child
                    
                } else {
                    currentNode.add(child: character)
                    if let newChild = currentNode.children[character] {
                        currentNode = newChild
                    }
                }
                
                currentIndex += 1
                
                if currentIndex == characters.count {
                    currentNode.isTerminating = true
                }
            }
        }
        
        func contains(word: String) -> Bool {
            guard !word.isEmpty else { return false }
            var currentNode = root
            
            let characters = Array(word.lowercased())
            
            var currentIndex = 0
            while currentIndex < characters.count {
                guard let child = currentNode.children[characters[currentIndex]] else { break }
                
                currentIndex += 1
                currentNode = child
            }
            
            if currentIndex == characters.count && currentNode.isTerminating {
                return true
            } else {
                return false
            }
        }
    }
    
    func uniqueMorseRepresentationsTrie(_ words: [String]) -> Int {
        
        let codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",
                     ".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",
                     ".--","-..-","-.--","--.."]
        
        var map = [Character : String]()
        for (index, val) in Array<Character>("abcdefghijklmnopqrstuvwxyz").enumerated() {
            map[val] = codes[index]
        }
        
        var count = 0
        let morseTrie = Trie()
        
        for word in words {
            guard !morseTrie.contains(word: translate(word, map)) else {
                continue
            }
            morseTrie.insert(word: translate(word, map))
            count += 1
        }
        
        return count
    }
}

// MARK: - Dict. Solution
extension Solution {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        
        let codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",
                     ".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",
                     ".--","-..-","-.--","--.."]
        
        var map = [Character : String]()
        for (index, val) in Array<Character>("abcdefghijklmnopqrstuvwxyz").enumerated() {
            map[val] = codes[index]
        }
        
        var wordSet = Set<String>()
        for word in words {
            wordSet.insert(self.translate(word, map))
        }
        
        return wordSet.count
    }
    
    fileprivate func translate(_ word: String, _ map: [Character : String]) -> String {
        var buffer = ""
        for char in word {
            if let morse = map[char] {
                buffer += morse
            }
        }
        return buffer
    }
}

let sol = Solution()
let params = ["gin", "zen", "gig", "msg"]
//let val = sol.uniqueMorseRepresentations(params)

let trieSolVal = sol.uniqueMorseRepresentationsTrie(params)

print(trieSolVal)

