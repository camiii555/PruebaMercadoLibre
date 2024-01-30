//
//  ProductTableViewCell.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 29/01/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productStatusLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productAttributesTableView: UITableView!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productAttributesTableViewHeightConstrain: NSLayoutConstraint!
    var productAttributes: [Attribute] = [] {
         didSet {
             updateTableViewHeight()
         }
     }
    
    fileprivate struct Cells {
        static let productAttributesTableViewCell = "ProductAttributesTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    //MARK: - Private Methods
    private func setupTableView() {
        productAttributesTableView.delegate = self
        productAttributesTableView.dataSource = self
        productAttributesTableView.rowHeight = UITableView.automaticDimension
        productAttributesTableView.estimatedRowHeight = 80
        registerCells()
    }
    
    private func registerCells() {
        productAttributesTableView.register(UINib(nibName: Cells.productAttributesTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.productAttributesTableViewCell)
    }
    
    //MARK: - Public Methods
    func updateTableViewHeight() {
        productAttributesTableView.reloadData()
        let tableViewHeight = productAttributesTableView.contentSize.height
        self.productAttributesTableViewHeightConstrain.constant = tableViewHeight
    }
    
}

extension ProductTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productAttributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.productAttributesTableViewCell, for: indexPath) as? ProductAttributesTableViewCell else { return UITableViewCell() }
        let attribute = productAttributes[indexPath.row]
        cell.attributeName.text = (attribute.name ?? "") + ":"
        cell.attributeValue.text = attribute.valueName
        return cell
    }
    
    
}

