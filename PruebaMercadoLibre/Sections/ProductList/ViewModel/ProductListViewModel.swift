//
//  ProductListViewModel.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import Foundation

class ProductListViewModel {
    private var products: [Result] = []

    func fetchProducts(query: String, completion: @escaping (Swift.Result<[Result], Error>) -> Void) {
        APIClient.shared.fetchData("https://api.mercadolibre.com/sites/MLC/search?q=\(query)", objectType: ProductListModel.self) { result in
            switch result {
            case .success(let products):
                self.products = products.results!
                completion(.success(products.results!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }

    func numberOfProducts() -> Int {
        return products.count
    }

    func product(at index: Int) -> Result {
        return products[index]
    }
}




