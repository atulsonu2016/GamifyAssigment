//
//  ViewController.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import UIKit

class GameListController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var txtfieldSearch: UITextField!
    @IBOutlet weak var searchBtnTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: CircularPageControl!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var animatedTextLabel: UILabel!
    @IBOutlet weak var pageControllerContainerView: UIView!
    
    
    // MARK: - Properties
    
    let fullText = "Search 'The Witcher'"
    lazy var currentIndex = 0
    var viewModel: GamelistViewModelType?
    var currentCollViewIndex = 0
    let debouncer = Debouncer(delay: 0.5)
    lazy var genreId = 0
        
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateViewAppearance()
    }
    
    // MARK: - View Model Binding
    
    private func bindViewModel() {
        viewModel?.onViewDidLoad()
        viewModel?.gameGenreList.observe(on: self) { [unowned self] data in
            self.genreId = data.first?.id ?? 0
            DispatchQueue.main.async {
                self.collView.reloadData()
            }
            self.setupPageControlUI()
        }
        viewModel?.gameList.observe(on: self, observerBlock: { [unowned self] _ in
            DispatchQueue.main.async {
                self.tblView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func searchBtnTapped(_ sender: UIButton) {
        textFieldContainerExpandedState()
    }
    
    @IBAction func clearTextBtnTapped(_ sender: UIButton) {
        textFieldContainerCollapsedState()
        viewModel?.getGameLists(genreId: genreId, searchText: nil)
    }
}

