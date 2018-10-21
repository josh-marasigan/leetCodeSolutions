import UIKit

class TrieNode {
    var value: Character?
    weak var parent: TrieNode?
    var children = [Character: TrieNode]()
    
    var isTerminating = false
    
    init() {
        self.value = nil
        self.parent = nil
    }
    
    init(value: Character? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child: Character) {
        guard self.children[child] == nil else { return }
        
        self.children[child] = TrieNode(value: child, parent: self)
    }
}

class Trie {
    typealias Node = TrieNode
    private let root: TrieNode
    
    init() {
        self.root = TrieNode()
    }
}

extension Trie {
    func insert(word: String) {
        guard !word.isEmpty else { return }
        
        var current = root
        
        let characters = Array(word.lowercased())
        var currentIndex = 0
        
        while currentIndex < characters.count {
            
            let char = characters[currentIndex]
            
            if let child = current.children[char] {
                current = child
            } else {
                current.add(child: char)
                current = current.children[char]!
            }
            
            currentIndex += 1
        }
        
        current.isTerminating = true
    }
    
    func contains(word: String) -> Bool {
        
        guard !word.isEmpty else { return false }
        var current = root
        let characters = Array(word.lowercased())
        var currentIndex = 0
        
        while currentIndex < characters.count,
        let child = current.children[characters[currentIndex]] {
            currentIndex += 1
            current = child
        }
        
        return currentIndex == characters.count && current.isTerminating
    }
}


let trie = Trie()
trie.insert(word: "Cat")
trie.contains(word: "Cat")
trie.contains(word: "Bat")
