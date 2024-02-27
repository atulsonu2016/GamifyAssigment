//
//  APIPath.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation


let environment = APIEnvironment.development
let baseURL = environment.baseURL()

struct APIPath {
    var gameGenre: String { return "\(baseURL)/genres"}
    var gameList: String { return "\(baseURL)/games"}
    var gameDetail: String {return "\(baseURL)/games"}
}


