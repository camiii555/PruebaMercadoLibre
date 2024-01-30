//
//  ProductDetailViewController.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 29/01/24.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var productDetailTabletView: UITableView!
    
    var product: Result?

    fileprivate struct Cells {
        static let productTableViewCell = "ProductTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if product != nil {
            setupTableView()
        }
    }
    
    //MARK: - Private Methods
    // Setup product detail table view cell
    private func setupTableView() {
        productDetailTabletView.delegate = self
        productDetailTabletView.dataSource = self
        registerCells()
    }
    
    // Register cells in table view
    private func registerCells() {
        productDetailTabletView.register(UINib(nibName: Cells.productTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.productTableViewCell)
    }
    
    
    // Method to change the state language to Spanish
    private func translateProductStatus(status: String) -> String {
        if status.lowercased().elementsEqual("new") {
            return "Nuevo"
        } else {
            return "Usado"
        }
    }
}

// MARK: - TableView Methods
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.productTableViewCell, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.productStatusLabel.text = translateProductStatus(status: (product?.condition)!)
        cell.productTitleLabel.text = product?.title
        let url = product?.thumbnail
        self.configureImage(with: url!, imageView: cell.productImage)
        cell.productPriceLabel.text = FormatPriceUtility.formatNumber(num: (product?.price)!)
        cell.productAttributes = (product?.attributes)!
        return cell
    }
}
