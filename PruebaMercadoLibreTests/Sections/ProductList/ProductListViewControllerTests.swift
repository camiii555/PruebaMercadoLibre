//
//  ProductListViewControllerTests.swift
//  PruebaMercadoLibreTests
//
//  Created by MacBook J&J  on 30/01/24.
//

import XCTest
@testable import PruebaMercadoLibre

class ProductListViewControllerTests: XCTestCase {
    
    var sut: ProductListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "productListVC") as? ProductListViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCollectionViewDataSource() {
        // Create an expectation to wait for data to load
        let dataLoadedExpectation = expectation(description: "Data loaded")
        
        // Simulate loading data into the view model
        sut.productListViewModel.fetchProducts(query: "motorola") { _ in
            dataLoadedExpectation.fulfill()
        }
        
        // Wait for data loading to complete
        wait(for: [dataLoadedExpectation], timeout: 5)
        
        // Verify that the number of items in the collection matches the number of products in the view model
        let numberOfItems = sut.collectionView(sut.productListCollectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, sut.productListViewModel.numberOfProducts())
        
        // Verify that cells are created correctly
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.productListCollectionView, cellForItemAt: indexPath)
        XCTAssertTrue(cell is ProductCollectionViewCell)
    }
    
    func testCollectionViewDelegate() {
        // Create an expectation to wait for data to load
        let dataLoadedExpectation = expectation(description: "Data loaded")
        
        // Simulate loading data into the view model
        sut.productListViewModel.fetchProducts(query: "motorola") { _ in
            dataLoadedExpectation.fulfill()
        }
        
        // Esperar a que la carga de datos se complete
        wait(for: [dataLoadedExpectation], timeout: 5)
        
        // Wait for data loading to complete
        let indexPath = IndexPath(item: 0, section: 0)
        let size = sut.collectionView(sut.productListCollectionView, layout: sut.productListCollectionView.collectionViewLayout, sizeForItemAt: indexPath)
        XCTAssertEqual(size.width, sut.productListCollectionView.frame.width / sut.numberOfColumns)
        XCTAssertEqual(size.height, 315)
        
        // Verify that navigation is performed when selecting an element
        let didSelectExpectation = expectation(description: "Did select item")
        
        // Use the performBatchUpdates method to simulate the collection update
        sut.productListCollectionView.performBatchUpdates({
            self.sut.productListCollectionView.delegate?.collectionView!(self.sut.productListCollectionView, didSelectItemAt: indexPath)
        }, completion: { _ in
            didSelectExpectation.fulfill()
        })
        
        // Wait for the element selection to complete
        wait(for: [didSelectExpectation], timeout: 5)
        
    }
    
    func testSearchBarDelegate() {
        // Verify that the search loads products
        let searchBar = sut.searchBar
        searchBar?.text = "motorola"
        sut.searchBarSearchButtonClicked(searchBar!)
        
        // Simulate product loading
        let fetchProductsExpectation = expectation(description: "Fetch products")
        sut.productListViewModel.fetchProducts(query: (searchBar?.text!)!) { _ in
            fetchProductsExpectation.fulfill()
        }
        wait(for: [fetchProductsExpectation], timeout: 5)
        
        // Verify that the collection is reloaded
        XCTAssertEqual(sut.productListCollectionView.numberOfItems(inSection: 0), sut.productListViewModel.numberOfProducts())
    }
    
}
