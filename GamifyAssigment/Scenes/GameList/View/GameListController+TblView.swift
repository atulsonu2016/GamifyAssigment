//
//  GameListController+TblView.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import Foundation
import UIKit

extension GameListController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the game list or 0 if the list is nil
        if (viewModel?.gameList.value.count ?? 0) < 1 {
            tblView.setEmptyView2(title: "No data found", message: "", msgColor: .white)
        } else {
            tblView.restore()
        }
        return viewModel?.gameList.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell and initialize it with data if available
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentDetailsCell.className, for: indexPath) as? ContentDetailsCell else {
            return UITableViewCell()
        }
        if let data = viewModel?.gameList.value[indexPath.row] {
            cell.initializeCell(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = viewModel?.gameList.value[indexPath.row] {
            NavigationHelper.getGameDetailController(self, GameDetailController.className, id: data.id ?? 0)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // Set the start and end offsets for alpha change
        let startAlphaChange: CGFloat = 50
        let endAlphaChange: CGFloat = 150
        
        // Handle alpha change based on scroll position
        DispatchQueue.main.async {
            if offset <= startAlphaChange {
                // Show collection view and page control if at the top of the table view
                UIView.animate(withDuration: 0.5) {
                    self.collView.alpha = 1.0
                    self.pageControllerContainerView.alpha = 1.0
                    self.collView.isHidden = false
                    self.pageControl.isHidden = false
                    self.pageControllerContainerView.isHidden = false
                }
            } else if offset >= endAlphaChange {
                // Hide collection view and page control if scrolled past the end offset
                if !self.collView.isHidden {
                    UIView.animate(withDuration: 0.5) {
                        self.collView.isHidden = true
                        self.pageControl.isHidden = true
                        self.pageControllerContainerView.isHidden = true
                    }
                }
            } else {
                // Calculate and set alpha based on scroll position between start and end offsets
                let alpha = 1.0 - (offset - startAlphaChange) / (endAlphaChange - startAlphaChange)
                UIView.animate(withDuration: 0.4) {
                    self.collView.alpha = alpha
                    self.pageControllerContainerView.alpha = alpha
                    self.collView.isHidden = false
                    self.pageControl.isHidden = false
                    self.pageControllerContainerView.isHidden = false
                }
            }
        }
    }
}
