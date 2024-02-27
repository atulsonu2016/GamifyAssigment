//
//  GameDetailViewModel.swift
//  Assigment
//
//  Created by Atul Sharan on 26/02/24.
//

import Foundation

protocol GameDetailViewModelTypeInput {
    func onViewDidLoad()
}

protocol GameDetailViewModelTypeOutput {
    var gameDetail: Observable<[GameDetailModel]> { get }
}

protocol GameDetailViewModelType: GameDetailViewModelTypeOutput, GameDetailViewModelTypeInput {
}

final class GameDetailViewModel: GameDetailViewModelType {
    var gameDetail: Observable<[GameDetailModel]> = Observable([])
    var gameId: Int
    
    init(gameId: Int) {
        self.gameId = gameId
    }
    
    func onViewDidLoad() {
        getAPIData(id: "\(self.gameId)")
    }
    
    
    
    private func getAPIData(id: String) {
        let request = GameDetailAPI()
        let param = ["key":Constants.APIKeys.kClientKey, "id": id]
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
            } else {
                if let result = model {
                    self.gameDetail.value.append(result)
                }
            }
        }
    }
}
