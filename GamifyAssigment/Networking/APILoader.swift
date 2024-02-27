import Foundation

struct APILoader<T: APIHandler> {
    var apiHandler: T
    let urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        let config = URLSessionConfiguration.default
        
        // Set up URLCache with appropriate size and disk capacity
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "urlCache")
        config.urlCache = cache
        
        // Assign the configured session to urlSession property
        self.urlSession = URLSession(configuration: config)
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        LoadingView.show()
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            // Check if the response is available in the cache
            if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: urlRequest) {
                do {
                    let parsedResponse = try self.apiHandler.parseResponse(data: cachedResponse.data, response: cachedResponse.response as! HTTPURLResponse)
                    completionHandler(parsedResponse, nil)
                    LoadingView.hide()
                    return
                } catch {
                    completionHandler(nil, ServiceError(httpStatus: 404, message: "ServiceError : \(error.localizedDescription)"))
                    LoadingView.hide()
                    return
                }
            }
            
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                LoadingView.hide()
                if let httpResponse = response as? HTTPURLResponse {
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                        completionHandler(parsedResponse, nil)
                        
                        // Cache the response for future use
                        let cachedResponse = CachedURLResponse(response: httpResponse, data: responseData)
                        self.urlSession.configuration.urlCache?.storeCachedResponse(cachedResponse, for: urlRequest)
                    } catch {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                }
            }.resume()
        }
    }
}
