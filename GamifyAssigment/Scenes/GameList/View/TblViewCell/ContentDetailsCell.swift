//
//  ContentDetailsCell.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import UIKit

class ContentDetailsCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 6
            containerView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initializeCell(data: GameList) {
        if let imageURL = data.backgroundImage {
            self.imgView.downloadImage(from: imageURL, contentMode: .scaleAspectFill)
        }
        titleLabel.text = data.name ?? ""
        subtitleLabel.text = "Release Date: \(data.released ?? "")"
    }
}
