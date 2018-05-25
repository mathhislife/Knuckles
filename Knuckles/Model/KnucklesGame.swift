//
//  KnucklesGame.swift
//  Knuckles
//
//  Created by Simon Kostenko on 24.05.2018.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

class KnucklesGame {
    
    //MARK: - Properties
    
    let box: Box
    
    //MARK: - Init
    
    init(rows: Int, columns: Int) {
        var knuckles = KnucklesGame.generateKnuckles(boxSize: rows * columns)
        repeat {
            knuckles.shuffle()
        } while !KnucklesGame.reshuffleIsValid(knuckles: knuckles)
        
        var resultKnuckles: [Knuckle?] = knuckles
        resultKnuckles.append(nil)
        
        box = Box(rows: rows, columns: columns, knuckles: resultKnuckles)
    }

    func pushKnuckle(at index: Int) {
        let coordinate: (row: Int, column: Int) = (index / box.rows, index % box.columns)
        let rowDifference = abs(coordinate.row - box.emptyCellCoordinate.row)
        let columnDifference = abs(coordinate.column - box.emptyCellCoordinate.column)
            
        if rowDifference + columnDifference == 1 {
            box[box.emptyCellIndex] = box[index]
            box[index] = nil
        }
    }
    
    //MARK: - Private Methods
    
    private static func generateKnuckles(boxSize: Int) -> [Knuckle] {
        var knuckles = [Knuckle]()
        for i in 1..<boxSize {
            knuckles.append(Knuckle(i))
        }
        
        return knuckles
    }
    
    private static func reshuffleIsValid(knuckles: [Knuckle]) -> Bool {
        var inversions = 0
        for i in 0..<knuckles.count {
            for j in 0..<i {
                if knuckles[j].number > knuckles[i].number {
                    inversions += 1
                }
            }
        }
        return (inversions & 1) == 0
    }
}
