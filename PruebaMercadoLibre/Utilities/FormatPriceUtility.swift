//
//  FormatPriceUtility.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import Foundation


class FormatPriceUtility {
    
    static func formatearPrecio(numero: Double) -> String {
        // Convert number to integer
        let numeroEntero = Int(numero)
        
        // Format integer as price
        let formateador = NumberFormatter()
        formateador.numberStyle = .currency
        formateador.minimumFractionDigits = 0
        formateador.maximumFractionDigits = 0
        
        if let precioFormateado = formateador.string(from: NSNumber(value: numeroEntero)) {
            return precioFormateado
        } else {
            return "Error al formatear el precio"
        }
    }
}
