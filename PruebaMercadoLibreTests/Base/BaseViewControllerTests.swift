//
//  BaseViewControllerTest.swift
//  PruebaMercadoLibreTests
//
//  Created by Juan Camilo Mejia  on 30/01/24.
//

import XCTest
@testable import PruebaMercadoLibre

class BaseViewControllerTests: XCTestCase {
    
    var sut: BaseViewController! 
    
    override func setUp() {
        super.setUp()
        sut = BaseViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testShowProgressOverCurrentContext() {
        sut.loadViewIfNeeded()
        
        let message = "Cargando..."
        let style = LoadingStyle.light
        let presentationContext = PresentationContext.overCurrentContext
        
        sut.showProgress(message: message, style: style, presentationContext: presentationContext)
        
        XCTAssertNotNil(sut.progress)
        XCTAssertEqual(sut.progress?.titleLabel.text, message)
    }
    
    func testShowProgressOverFullScreen() {
        sut.loadViewIfNeeded()
        
        let message = "Cargando..."
        let style = LoadingStyle.light
        let presentationContext = PresentationContext.overFullScreen
        
        sut.showProgress(message: message, style: style, presentationContext: presentationContext)
        
        XCTAssertNotNil(sut.progress)
        XCTAssertEqual(sut.progress?.titleLabel.text, message)
    }
    
    func testConfigureImage() {
        let imageUrl = "https://www.adslzone.net/app/uploads-adslzone.net/2019/04/borrar-fondo-imagen.jpg"
        let imageView = UIImageView()
        
        let expectation = XCTestExpectation(description: "Image download completed")
        
        sut.configureImage(with: imageUrl, imageView: imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(imageView.image)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testShowAlert() {
        var alertTitle: String?
        var alertMessage: String?

        // Inject a test handler
        sut.showAlertHandler = { title, message in
            alertTitle = title
            alertMessage = message
        }

        // Call the method you want to test
        sut.showAlert(title: "Test Title", message: "Test Message")

        // Assert that the showAlertHandler was called with the correct parameters
        XCTAssertEqual(alertTitle, "Test Title")
        XCTAssertEqual(alertMessage, "Test Message")
    }
}
