//
//  ResponseHandler+Extension.swift
//  Assigment
//
//  Created by Atul Sharan on 23/02/24.
//

import Foundation
// MARK: Response Handler - parse default

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch let decodingError as DecodingError {
            // Handle decoding errors
            print("Decoding error:", decodingError)
            throw ServiceError(httpStatus: response.statusCode, message: decodingError.localizedDescription)
        } catch {
            // Handle other errors
            print("Unknown error:", error)
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
    }
}


