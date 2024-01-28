//
//  APIClient.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 28/01/24.
//
import Foundation

class APIClient {
    static let shared = APIClient()

    private init() {}

    func fetchData<T: Decodable>(_ urlString: String, objectType: T.Type, completion: @escaping (APIResult<T>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print("URL -> \(url)")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
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

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
}

enum APIResult<T> {
    case success(T)
    case failure(APIError)
}


