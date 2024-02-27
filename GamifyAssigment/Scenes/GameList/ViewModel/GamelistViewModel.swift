//
//  GamelistViewModel.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import Foundation

protocol GamelistViewModelTypeInput {
    func onViewDidLoad()
    func getGameLists(genreId: Int, searchText: String?)
    func updateTablePageNumber(pageNumber: Int)
    func updateCollectionPageNumber(pageNumber: Int)
}

protocol GamelistViewModelTypeOutput {
    var gameGenreList: Observable<[GameGenre]> { get }
    var gameList: Observable<[GameList]> { get }
    var tablePageNumber: Observable<Int> {get}
    var collectionPageNumber: Observable<Int> { get }
}

protocol GamelistViewModelType:GamelistViewModelTypeOutput, GamelistViewModelTypeInput {
}

final class GamelistViewModel: GamelistViewModelType {
    lazy var tablePageNumber: Observable<Int> = Observable(1)
    
    lazy var collectionPageNumber: Observable<Int> = Observable(1)
    
    lazy var gameGenreList: Observable<[GameGenre]> = Observable([])
    lazy var gameList: Observable<[GameList]> = Observable([])
        
    func onViewDidLoad() {
        getAPIData()
    }
    
    func updateTablePageNumber(pageNumber: Int) {
        tablePageNumber.value = pageNumber
    }
    
    func updateCollectionPageNumber(pageNumber: Int) {
        collectionPageNumber.value = pageNumber
    }
    
    func getGameLists(genreId: Int, searchText: String?) {
        getGameList(genreId: genreId, searchText: searchText)
    }
    
    private func getAPIData() {
        let request = GameGenreAPI()
        let param = ["key":Constants.APIKeys.kClientKey]
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
            } else {
                if let result = model?.results {
                    self.gameGenreList.value = result
                    if let id = self.gameGenreList.value.first?.id {
                        self.getGameList(genreId: id, searchText: nil)
                    }
                }
            }
        }
    }
    
    private func getGameList(genreId: Int, searchText: String?) {
        let request = GameListAPI()
        var param:[String: Any] = ["key":Constants.APIKeys.kClientKey]
        param["genres"] = genreId
        if let text = searchText {
            param["search"] = text
        }
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
            } else {
                if let result = model?.results {
                    self.gameList.value = result
                }
            }
        }
    }
}
