//
//  GameListController+CollView.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation
import UIKit

extension GameListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the game genre list or 0 if the list is nil
        return viewModel?.gameGenreList.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue a reusable cell and initialize it with data if available
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollCell.className, for: indexPath) as? ImageCollCell else {
            return UICollectionViewCell()
        }
        if let data = viewModel?.gameGenreList.value[indexPath.row] {
            cell.initializeCell(with: data)
        }
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Update the current page indicator and trigger fetching game lists for the selected genre
        if let _ = scrollView as? UICollectionView {
            for cell in collView.visibleCells {
                let indexPath = collView.indexPath(for: cell)
                pageControl.currentPage = indexPath?.row ?? 0
                
                // Update the current collection view index for reference
                self.currentCollViewIndex = indexPath?.row ?? 0
                
                // Fetch game lists for the selected genre
                genreId = self.viewModel?.gameGenreList.value[indexPath?.row ?? 0].id ?? 0
                textFieldContainerCollapsedState()
                viewModel?.getGameLists(genreId: genreId, searchText: nil)
            }
        }
    }
}
