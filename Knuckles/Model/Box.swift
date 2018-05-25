//
//  Box.swift
//  Knuckles
//
//  Created by Simon Kostenko on 22.05.2018.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import Foundation

class Box {
    let rows: Int
    let columns: Int
    private var knuckles: [Knuckle?]
    
    var size: Int {
        return rows * columns
    }
    
    var emptyCellCoordinate: (row: Int, column: Int) {
        let index = knuckles.index { $0 == nil }!
        return (index / rows, index % rows)
    }
    
    var emptyCellIndex: Int {
        return knuckles.index { $0 == nil }!
    }
    
    init(rows: Int, columns: Int, knuckles: [Knuckle?]) {
        self.rows = rows
        self.columns = columns
        self.knuckles = knuckles
    }
    
    subscript(index: Int) -> Knuckle? {
        get {
            return knuckles[index]
        }
        set {
            knuckles[index] = newValue
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
