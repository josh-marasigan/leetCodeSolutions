import UIKit

class Solution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        guard people.count > 1 else { return people }
        
        // sort by height
        let sortedPeople = self.quicksort(people)
        var reconstructedQueue = [[Int]]()
        for person in sortedPeople {
            self.insertAtQueue(person, &reconstructedQueue)
        }
        
        return reconstructedQueue
    }
    
    private func insertAtQueue(_ person: [Int], _ queue: inout [[Int]]) {
        guard queue.count > 0 else {
            queue.append(person)
            return
        }
        
        queue.insert(person, at: (person[1]))
    }
    
    private func quicksort(_ people: [[Int]]) -> [[Int]] {
        guard people.count > 1 else { return people }
        
        // Divide and Conq.
        let pivot = people[people.count/2]
        
        // Sort equal heights by ascending count
        let median = people.filter { $0[0] == pivot[0] }.sorted { $0[1] < $1[1] }
        let lesser = people.filter { $0[0] < pivot[0] }
        let greater = people.filter { $0[0] > pivot[0] }
        
        return self.quicksort(greater) + median + self.quicksort(lesser)
    }
}

//Solution().reconstructQueue([[6,0],[5,0],[4,0],[3,2],[2,2],[1,4]])
//Solution().reconstructQueue([[0,0],[6,2],[5,5],[4,3],[5,2],[1,1],[6,0],[6,3],[7,0],[5,1]])
