//
//  ProductAttributesTableViewCell.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 29/01/24.
//

import UIKit

class ProductAttributesTableViewCell: UITableViewCell {

    @IBOutlet weak var attributeName: UILabel!
    @IBOutlet weak var attributeValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
