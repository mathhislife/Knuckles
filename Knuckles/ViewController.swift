//
//  ViewController.swift
//  Knuckles
//
//  Created by Simon Kostenko on 22.05.2018.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let knuckleReuseIdentifier = "KnuckleCell"
    private let emptyCellReuseIdentifier = "EmptyCell"
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    private let spaceBetweenItems: CGFloat = 8.0
    private let knucklesGame = KnucklesGame(rows: 4, columns: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 20.0
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: emptyCellReuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return knucklesGame.box.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let knuckle = knucklesGame.box[indexPath.row] else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell",
                                                      for: indexPath)
        }
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: knuckleReuseIdentifier,
                                                      for: indexPath) as! KnuckleCell
        cell.titleLabel.text = "\(knuckle.number)"
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = spaceBetweenItems * CGFloat(knucklesGame.box.columns - 1) +
            sectionInsets.left + sectionInsets.right
        let availableWidth = collectionView.frame.width - paddingSpace
        var widthPerItem = availableWidth / CGFloat(knucklesGame.box.columns)
        widthPerItem -= 2
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenItems
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        knucklesGame.pushKnuckle(at: indexPath.row)
        collectionView.reloadData()
    }
}
