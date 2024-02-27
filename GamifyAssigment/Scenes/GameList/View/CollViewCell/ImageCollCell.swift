//
//  ImageCollCell.swift
//  Assignment
//
//  Created by Atul Sharan on 23/02/24.
//

import UIKit

class ImageCollCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    /// The container view for the cell.
    @IBOutlet weak var containerView: CustomShadowView! {
        didSet {
            containerView.layer.cornerRadius = 12
            containerView.clipsToBounds = true
        }
    }
    
    /// The image view displaying the game genre image.
    @IBOutlet weak var imgView: UIImageView!
    
    /// The label displaying the game genre title.
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Custom Methods
    
    /// Initializes the cell with the provided game genre data.
    ///
    /// - Parameter data: The game genre data to populate the cell.
    func initializeCell(with data: GameGenre) {
        // Load and display the game genre image
        if let imageURLString = data.imageBackground {
            self.imgView.downloadImage(from: imageURLString, contentMode: .scaleAspectFill)
        }
        
        // Set the title label text
        titleLabel.text = data.name ?? ""
    }
}
