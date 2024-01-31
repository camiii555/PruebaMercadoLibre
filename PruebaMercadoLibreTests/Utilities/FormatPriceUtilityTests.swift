//
//  FormatPriceUtilityTests.swift
//  PruebaMercadoLibreTests
//
//  Created by Juan Camilo Mejia  on 30/01/24.
//

import XCTest
@testable import PruebaMercadoLibre

class FormatPriceUtilityTests: XCTestCase {
    
    func testFormatNumber() {
        // Act
        let formattedPrice = FormatPriceUtility.formatNumber(num: 12311.6)

        // Assert
        XCTAssertEqual(formattedPrice, "$ 12.312")
    }

    func testFormatNumberWithZeroFractionDigits() {
        // Act
        let formattedPrice = FormatPriceUtility.formatNumber(num: 9876)

        // Assert
        XCTAssertEqual(formattedPrice, "$ 9.876")
    }

    func testFormatNumberWithError() {
        // Act
        let formattedPrice = FormatPriceUtility.formatNumber(num: Double.nan)

        // Assert
        XCTAssertEqual(formattedPrice, "Error al formatear el precio", "La función de formateo no manejó correctamente el error")
    }
}
