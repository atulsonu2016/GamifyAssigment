//
//  APIEnvironment.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//
import Foundation
enum APIEnvironment {
    case development
    
    func baseURL () -> String {
        return "https://\(domain())/\(subdomain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "api.rawg.io"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development:
            return "api"
        }
    }
}
