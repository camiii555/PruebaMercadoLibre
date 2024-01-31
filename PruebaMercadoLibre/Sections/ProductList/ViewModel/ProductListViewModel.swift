//
//  ProductListViewModel.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import Foundation


class ProductListViewModel {
    
    // Private property to store the list of products.
    private var products: [Result] = []

    // Function to fetch products based on a query string.
    func fetchProducts(query: String, completion: @escaping (Swift.Result<[Result], Error>) -> Void) {
        
        // Use the shared instance of APIClient to fetch data from the API.
        APIClient.shared.fetchData(urlString: Constants.ApiUrls.apiListOfProducts, objectType: ProductListModel.self, method: .get, parameters: ["q" : query]) { result in
            // Handle the result of the API call.
            switch result {
            case .success(let products):
                // If the API call is successful, update the local products array and call the completion handler with success.
                self.products = products.results ?? [Result]()
                completion(.success(self.products))
            case .failure(let error):
                // If the API call fails, call the completion handler with the received error.
                completion(.failure(error))
            }
        }
    }

    // Function to get the number of products in the list.
    func numberOfProducts() -> Int {
        return products.count
    }

    // Function to get the product at a specific index in the list.
    func product(at index: Int) -> Result {
        return products[index]
    }
}




