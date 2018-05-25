//
//  KnuckleCell.swift
//  Knuckles
//
//  Created by Simon Kostenko on 25.05.2018.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

class KnuckleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
    }
}
