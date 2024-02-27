//
//  GameDetailController.swift
//  Assigment
//
//  Created by Atul Sharan on 26/02/24.
//

import UIKit

class GameDetailController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var containerThumbnailImage: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var achievementCountLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    // MARK: - ViewModel
    var viewModel: GameDetailViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel?.onViewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViewAppearanceAppear()
    }

    // MARK: - Actions
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension for UI setup and animations
extension GameDetailController {
    // Setup UI elements
    func setupUI() {
        setupThumbnailImgView()
        setupThumbnailContainerView()
    }
    
    // Setup thumbnail view
    func setupThumbnailContainerView() {
        containerThumbnailImage.layer.cornerRadius = 20
        containerThumbnailImage.clipsToBounds = true
    }
    
    // Setup thumbnail image view
    func setupThumbnailImgView() {
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.clipsToBounds = true
    }
    
    // Animate appearance of the view
    func animateViewAppearanceAppear() {
        self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .showHideTransitionViews, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
}

// MARK: - Extension for ViewModel binding
extension GameDetailController {
    // Bind ViewModel to UI elements
    func bindViewModel() {
        viewModel?.gameDetail.observe(on: self, observerBlock: { [unowned self] data in
            if data.count > 0 {
                DispatchQueue.main.async {
                    let gameData = data[0]
                    self.thumbnailImageView.downloadImage(from: gameData.backgroundImage ?? "", contentMode: .scaleAspectFill)
                    self.titleLabel.text = gameData.name ?? ""
                    self.releaseDate.text = "Released on: \(gameData.released ?? "")"
                    self.descriptionTextView.text = gameData.descriptionRaw ?? ""
                    self.ratingsLabel.text = "\(gameData.rating ?? 0)/5"
                    self.developerLabel.text = gameData.developers?.first?.name ?? ""
                    self.achievementCountLabel.text = "\(gameData.achievementsCount ?? 0)"
                    self.languageLabel.text = gameData.tags?.first?.language ?? ""
                }
            }
        })
    }
}
