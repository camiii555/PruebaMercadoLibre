//
//  ProductDetailViewControllerTests.swift
//  PruebaMercadoLibreTests
//
//  Created by Juan Camilo Mejia  on 30/01/24.
//

import XCTest
@testable import PruebaMercadoLibre

class ProductDetailViewControllerTests: XCTestCase {
    
    var sut: ProductDetailViewController!
    
    override func setUp() {
        super.setUp()
        sut = ProductDetailViewController()
        // Load the view hierarchy to trigger viewDidLoad
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Mocks
    
    class MockTableView: UITableView {
        var didRegisterNib = false
        
        override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
            didRegisterNib = true
            super.register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    // MARK: - Tests
    
    func testSetupTableView() {
        let mockTableView = MockTableView()
        sut.productDetailTabletView = mockTableView
        
        sut.setupTableView()
        
        XCTAssertTrue(mockTableView.delegate === sut)
        XCTAssertTrue(mockTableView.dataSource === sut)
        XCTAssertTrue(mockTableView.didRegisterNib)
    }
    
    func testRegisterCells() {
        let mockTableView = MockTableView()
        sut.productDetailTabletView = mockTableView
        
        sut.registerCells()
        
        XCTAssertTrue(mockTableView.didRegisterNib)
    }
    
    func testTranslateProductStatus_New() {
        let translatedStatus = sut.translateProductStatus(status: "New")
        XCTAssertEqual(translatedStatus, "Nuevo")
    }
    
    func testTranslateProductStatus_Used() {
        let translatedStatus = sut.translateProductStatus(status: "Used")
        XCTAssertEqual(translatedStatus, "Usado")
    }
}

