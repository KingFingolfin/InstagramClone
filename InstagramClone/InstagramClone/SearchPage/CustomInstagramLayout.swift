//
//  CustomInstagramLayout.swift
//  Instagram
//
//  Created by Imac on 24.11.24.
//

import Foundation
import UIKit

class CustomInstagramLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.width
        let itemSpacing: CGFloat = 1
        let normalItemsPerRow: CGFloat = 3
        
        let totalSpacing = itemSpacing * (normalItemsPerRow - 1)
        let normalItemWidth = (availableWidth - totalSpacing) / normalItemsPerRow
        let largeItemWidth = (normalItemWidth * 2) + itemSpacing
        let largeItemHeight = (normalItemWidth * 2) + itemSpacing
        
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        var yOffset: [CGFloat] = Array(repeating: 0, count: Int(normalItemsPerRow))
        var currentColumn = 0
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let isLargeItem = (item + 1) % 8 == 0
            _ = isLargeItem ? largeItemWidth : normalItemWidth
            _ = isLargeItem ? largeItemHeight : normalItemWidth
            
            if isLargeItem {
                let minY = yOffset.min() ?? 0
                currentColumn = yOffset.firstIndex(of: minY) ?? 0
                
                if currentColumn > Int(normalItemsPerRow) - 2 {
                    currentColumn = 0
                }
                
                let xOffset = currentColumn == 0 ? 0 : (normalItemWidth + itemSpacing) * CGFloat(currentColumn)
                
                attributes.frame = CGRect(
                    x: xOffset,
                    y: minY,
                    width: largeItemWidth,
                    height: largeItemHeight
                )
                
                let maxY = minY + largeItemHeight + itemSpacing
                yOffset[currentColumn] = maxY
                yOffset[currentColumn + 1] = maxY
                
                currentColumn = 0
            } else {
                var minY = CGFloat.greatestFiniteMagnitude
                var minColumn = 0
                
                for (index, y) in yOffset.enumerated() {
                    if y < minY {
                        minY = y
                        minColumn = index
                    }
                }
                
                currentColumn = minColumn
                
                let xOffset = (normalItemWidth + itemSpacing) * CGFloat(currentColumn)
                
                attributes.frame = CGRect(
                    x: xOffset,
                    y: minY,
                    width: normalItemWidth,
                    height: normalItemWidth
                )
                
                yOffset[currentColumn] = minY + normalItemWidth + itemSpacing
            }
            
            layoutAttributes.append(attributes)
        }
        
        self.itemSize = CGSize(width: normalItemWidth, height: normalItemWidth)
        self.minimumInteritemSpacing = itemSpacing
        self.minimumLineSpacing = itemSpacing
        
        self.cachedAttributes = layoutAttributes
    }
    
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let height = cachedAttributes.map { $0.frame.maxY }.max() ?? 0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes.first { $0.indexPath == indexPath }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return newBounds.width != collectionView.bounds.width
    }
}
