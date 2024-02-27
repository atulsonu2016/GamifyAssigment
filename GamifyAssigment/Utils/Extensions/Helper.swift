//
//  Helper.swift
//  Assigment
//
//  Created by Atul Sharan on 24/02/24.
//

import UIKit

//MARK: - Collection Extension
extension Collection {
    // Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//MARK: - UICollectionView Extension
extension UICollectionView {
    func register(nib nibName: [String]) {
        nibName.forEach { name in
            let nib = UINib(nibName: name, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: name)
        }
    }
}

//MARK: - UITableView Extension
extension UITableView {
    func register(nib nibName: [String]) {
        nibName.forEach { name in
            let nib = UINib(nibName: name, bundle: nil)
            self.register(nib, forCellReuseIdentifier: name)
        }
    }
}

//MARK: - NSObject Extension
extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

//MARK: - Storyboard Enum
enum StoryBoard: String {
    case Main = "Main"
}

//MARK: - UIImageView Extension
extension UIImageView {
    public static let imageCache = NSCache<NSString, UIImage>()

    func downloadImage(from urlString: String, contentMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImage(from: url, contentMode: contentMode)
    }

    func downloadImage(from url: URL, contentMode: UIView.ContentMode) {
        DispatchQueue.main.async {
            self.contentMode = contentMode
        }
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                    UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }
            }
        }.resume()
    }
}

//MARK: - Debouncer Class
class Debouncer {
    var delay: TimeInterval
    var timer: Timer?

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func debounce(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}

//MARK: - CircularPageControl Class
class CircularPageControl: UIPageControl {
    
    // Override currentPage property to trigger redraw on change
    override var currentPage: Int {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    // Override numberOfPages property to trigger redraw on change
    override var numberOfPages: Int {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    // Customize the appearance of the page control
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Clear the background to remove default dots
        backgroundColor = UIColor.clear
        
        // Calculate the dimensions for individual page indicators
        let indicatorWidth: CGFloat = 9
        let indicatorSpacing: CGFloat = 7
        let indicatorHeight: CGFloat = (bounds.height / 2) - 1
        let totalIndicatorWidth = CGFloat(numberOfPages) * indicatorWidth + max(0, CGFloat(numberOfPages - 1)) * indicatorSpacing
        let startX = (bounds.size.width - totalIndicatorWidth) / 2
        
        // Define properties for current and non-current indicators
        let currentColor = UIColor.white
        let nonCurrentColor = UIColor.lightGray
        
        // Loop through all page indicators
        for i in 0..<numberOfPages {
            let indicatorRect = CGRect(x: startX + CGFloat(i) * (indicatorWidth + indicatorSpacing),
                                       y: (bounds.size.height - indicatorHeight) / 2,
                                       width: indicatorWidth,
                                       height: indicatorHeight)
            
            // Draw indicator circle
            let ovalPath = UIBezierPath(ovalIn: indicatorRect)
            if i == currentPage {
                currentColor.setFill()
            } else {
                nonCurrentColor.setFill()
            }
            ovalPath.fill()
            
            // Draw border for the current page
            if i == currentPage {
                let borderRect = CGRect(x: indicatorRect.minX - 1,
                                        y: indicatorRect.minY - 1,
                                        width: indicatorRect.width + 2,
                                        height: indicatorRect.height + 2)
                currentColor.setStroke()
                let borderPath = UIBezierPath(ovalIn: borderRect)
                borderPath.lineWidth = 1.0
                borderPath.stroke()
            }
        }
    }
}

//MARK: - UITableView Extension
extension UITableView {
    func setEmptyView2(title: String, message: String, msgColor: UIColor = .white) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = msgColor
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = msgColor
        messageLabel.font = .boldSystemFont(ofSize: 13)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        // Constraints to center the labels within the parent view
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 15).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -15).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
