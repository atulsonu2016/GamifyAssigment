//
//  APIHandler.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation

// MARK: APIHandler

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data:RequestDataType) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler
