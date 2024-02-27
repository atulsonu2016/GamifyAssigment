//
//  Services.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import Foundation

////Genre
struct GameGenreAPI: APIHandler {    
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().gameGenre
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> GameGenreModel {
        return try defaultParseResponse(data: data,response: response)
    }
}

struct GameListAPI: APIHandler {
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().gameList
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> GameListModel {
        return try defaultParseResponse(data: data,response: response)
    }
}

struct GameDetailAPI: APIHandler {    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        var paramNew = param
        let id = param["id"]
        var urlString =  APIPath().gameList
        urlString.append("/\(id ?? "")")
        paramNew.removeValue(forKey: "id")
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: paramNew, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> GameDetailModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
