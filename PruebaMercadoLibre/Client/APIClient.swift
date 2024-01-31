//
//  APIClient.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//
import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    internal init() {}
    
    func fetchData<T: Decodable>(
        urlString: String,
        objectType: T.Type,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        parameters: [String: Any]? = nil,
        httpBody: Data? = nil,
        completion: @escaping (APIResult<T>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Add query parameters if any
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add custom headers if any
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set HTTP body if provided
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        
        print("URL -> \(request)")
        print("Method -> \(String(describing: request.httpMethod))")
        print("Headers -> \(String(describing: request.allHTTPHeaderFields))")
        print("Body -> \(String(describing: request.httpBody))")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                // Check for error status code
                if httpResponse.statusCode >= 400 {
                    completion(.failure(.networkError(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil))))
                    return
                }
                
                // Parse data only for successful status codes
                if let data = data {
                    do {
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedObject))
                        }
                    } catch let decodingError {
                        completion(.failure(.decodingError(decodingError)))
                    }
                } else {
                    completion(.failure(.noData))
                }
            } else if let error = error {
                completion(.failure(.networkError(error)))
            }
        }.resume()
    }


}


enum APIError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData):
            return true
        case let (.decodingError(error1), .decodingError(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case let (.networkError(error1), .networkError(error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

enum APIResult<T> {
    case success(T)
    case failure(APIError)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

