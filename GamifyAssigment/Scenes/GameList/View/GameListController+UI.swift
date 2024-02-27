//
//  ViewController+UI.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation
import UIKit

extension GameListController {
    // MARK: - UI Setup
    
    func animateViewAppearance() {
        self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    func setupUI() {
        setupCollectionView()
        setupStackViewUI()
        setupTableView()
        setupTextField()
    }
    
    func setupCollectionView() {
        // Set up collection view
        collView.delegate = self
        collView.dataSource = self
        collView.register(nib: [ImageCollCell.className])
        
        // Apply custom collection view layout
        let layout = CoverFlowLayout()
        collView.collectionViewLayout = layout
    }
    
    func setupTableView() {
        // Set up table view
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(nib: [ContentDetailsCell.className])
    }
    
    func setupStackViewUI() {
        // Set corner radius for stack view
        stackView.layer.cornerRadius = 12.0
        stackView.clipsToBounds = true
    }
    
    func setupTextField() {
        txtfieldSearch.delegate = self
    }
    // MARK: - Text Field Container States
    
    func textFieldContainerExpandedState() {
        // Animate text field container expansion
        UIView.animate(withDuration: 0.25, delay: 0, options: .layoutSubviews) {
            self.currentIndex = 0
            self.searchButton.setTitle("", for: .normal)
            self.stackView.semanticContentAttribute = .forceLeftToRight
            self.animatedTextLabel.isHidden = false
            self.animatedTextLabel.text = ""
            self.textFieldContainerView.isHidden = false
            
            // Create and add animated text label after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.updateText(label: self.animatedTextLabel)
            }
        }
    }
    
    func textFieldContainerCollapsedState() {
        // Animate text field container collapse
        UIView.animate(withDuration: 0.25, delay: 0, options: .layoutSubviews) {
            self.stackView.semanticContentAttribute = .forceLeftToRight
            self.textFieldContainerView.isHidden = true
            self.searchButton.setTitle("Search", for: .normal)
            
            // Remove animated text label and reset index
            self.animatedTextLabel.isHidden = true
            self.animatedTextLabel.text = ""
            self.currentIndex = 0
            
            // Resign textfield responder
            self.txtfieldSearch.text = ""
            self.txtfieldSearch.resignFirstResponder()
        }
    }
    
    // MARK: - Auto-Writing Text
    
    func updateText(label: UILabel) {
        guard currentIndex <= fullText.count else {
            return
        }
        
        // Get the substring and update label's text
        let substring = String(fullText.prefix(currentIndex))
        label.text = substring
        
        // Increment index and schedule next update
        currentIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateText(label: label)
        }
    }
    
    // MARK: - Setup page control
    
    func setupPageControlUI() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel?.gameGenreList.value.count ?? 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Textfield Delegate Methods

extension GameListController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (textField.text?.count ?? 0) < 1 {
            self.animatedTextLabel.isHidden = false
            self.clearTextButton.isHidden = true
        } else {
            self.animatedTextLabel.isHidden = true
            self.clearTextButton.isHidden = false
        }
        
        debouncer.debounce {
            if let text = textField.text {
                self.viewModel?.getGameLists(genreId: self.genreId, searchText: text)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
