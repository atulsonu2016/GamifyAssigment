//
//  CollectionView+Helper.swift
//  Assigment
//
//  Created by Atul Sharan on 24/02/24.
//

import Foundation
import UIKit

class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: (self.collectionView?.bounds.width ?? 0) - 10, height: self.collectionView?.bounds.height ?? 0)
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        guard let collectionView = collectionView else { return layoutAttributes }
        
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        
        for attributes in layoutAttributes ?? [] {
            let distance = abs(attributes.center.x - centerX)
            let scale = 1 - (distance / (collectionView.bounds.width)) * 0.5
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        var proposedContentOffset = proposedContentOffset
        let pageWidth = itemSize.width + minimumLineSpacing
        let currentPage = collectionView.contentOffset.x / pageWidth
        let nearestPage: CGFloat
        
        if velocity.x > 0 {
            nearestPage = ceil(currentPage)
        } else if velocity.x < 0 {
            nearestPage = floor(currentPage)
        } else {
            nearestPage = round(currentPage)
        }
        
        proposedContentOffset.x = nearestPage * pageWidth
        return proposedContentOffset
    }
}

