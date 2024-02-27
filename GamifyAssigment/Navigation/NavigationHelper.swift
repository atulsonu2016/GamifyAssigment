//
//  NavigationHelper.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import UIKit

class NavigationHelper: NSObject {
    class func getViewControler(storyBoard: StoryBoard, indentifire: String) -> UIViewController {
        let storyB = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        return storyB.instantiateViewController(withIdentifier: indentifire)
    }
    
    class func getGameListController(storyBoard: StoryBoard, indentifire: String) -> GameListController {
        let storyB = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let controller = storyB.instantiateViewController(withIdentifier: indentifire) as? GameListController
        let viewModel = GamelistViewModel()
        controller?.viewModel = viewModel
        return controller ?? GameListController()
    }
    
    class func getGameDetailController(_ sourceView:UIViewController,_ destinationViewIdentifier:String, id: Int) {
        guard let destinationViewC = getViewControler(storyBoard: .Main, indentifire:destinationViewIdentifier) as? GameDetailController else { return }
        let viewModel = GameDetailViewModel(gameId: id)
        destinationViewC.viewModel = viewModel
        sourceView.navigationController?.navigationBar.isHidden = true
        sourceView.navigationController?.pushViewController(destinationViewC, animated: true)
    }
}
