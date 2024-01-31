//
//  FormatPriceUtility.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import Foundation


class FormatPriceUtility {
    
    static func formatNumber(num: Double) -> String {
        
        guard num.isFinite else {
            return "Error al formatear el precio"
        }
        // Convert number to integer
        let newNum = Int(ceil(num))
        // Format integer as price
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        if let formattedNumber = formatter.string(from: NSNumber(value: newNum)) {
            return formattedNumber
        } else {
            return "Error al formatear el precio"
        }
    }
}
