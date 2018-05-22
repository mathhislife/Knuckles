//
//  Box.swift
//  Knuckles
//
//  Created by Simon Kostenko on 22.05.2018.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import Foundation

class Box {
    let n = 4
    let m = 4
    var knuckles: [Knuckle]
    private var emptyPositionIndex: Int
    
    init() {
        knuckles = [Knuckle]()
        for i in 0..<n*m {
            knuckles.append(Knuckle(i))
        }
        emptyPositionIndex = 0
        
        repeat {
            knuckles.shuffle()
        } while !reshuffleIsValid(knuckles: knuckles)
        
        for i in 0..<n*m {
            if knuckles[i].number == 0 {
                emptyPositionIndex = i
            }
        }
    }
    
    private func reshuffleIsValid(knuckles: [Knuckle]) -> Bool {
        var inversions = 0
        for i in 0..<n*m {
            if knuckles[i].number != 0 {
                for j in 0..<i {
                    if knuckles[j].number > knuckles[i].number {
                        inversions += 1
                    }
                }
            }
        }
        for i in 0..<n*m {
            if knuckles[i].number == 0 {
                inversions += 1 + i / m
            }
        }
        return (inversions & 1) == 0
    }
    
    private func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < n && column >= 0 && column < m
    }
    
    //MARK: Public methods
    
    subscript(row: Int, column: Int) -> Knuckle {
        assert(indexIsValid(row: row, column: column), "Index out of range")
        return knuckles[row * m + column]
    }
    
    func pushKnuckleAt(row: Int, column: Int) {
        assert(indexIsValid(row: row, column: column), "Index out of range")
        let emptyI = emptyPositionIndex / m
        let emptyJ = emptyPositionIndex % m
        
        let iDifference = abs(row - emptyI)
        let jDifference = abs(column - emptyJ)
        if iDifference + jDifference == 1 {
            knuckles.swapAt(emptyPositionIndex, row + m + column)
            emptyPositionIndex = row + m + column
        }
    }
}


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
