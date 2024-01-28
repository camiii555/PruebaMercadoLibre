//
//  ProductListViewController.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 28/01/24.
//

import UIKit

class ProductListViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    fileprivate struct Cells {
        static let productCollectionViewCell = "ProductCollectionViewCell"
    }
    
    var numberOfColumns: CGFloat = 2
    
    let productListViewModel = ProductListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        productListViewModel.fetchProducts(query: "usb 1tb") { result in
            switch result {
            case .success(_):
                self.productListCollectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            // Update the number of columns in the layout during the transition
            self.updateCollectionViewLayout()
        }, completion: nil)
    }
    
    //MARK: - Private Methods
    // collection view configuration
    private func setupCollectionView() {
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        registerCell()
        configureCollectionViewLayout()
    }
    
    // Register the cells in the collection view
    private func registerCell() {
        productListCollectionView.register(UINib(nibName: Cells.productCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.productCollectionViewCell)
    }
    
    // Set the layout of the collection view
    private func configureCollectionViewLayout() {
        if let flowLayout = productListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            updateCollectionViewLayout()
        }
    }
    
    // Function to update the collectionview layout based on orientation
    private func updateCollectionViewLayout() {
        if UIDevice.current.orientation.isLandscape {
            numberOfColumns = 3
        } else {
            numberOfColumns = 2
        }

        if let flowLayout = productListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
            // Tells the collectionview to load its data and adjust the layout
            productListCollectionView.reloadData()
        }
    }
    
}

//MARK: - Collection View Methods
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListViewModel.numberOfProducts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.productCollectionViewCell, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let product = productListViewModel.product(at: indexPath.row)
        
        cell.productName.text =  product.title
        cell.productPrice.text = FormatPriceUtility.formatearPrecio(numero: product.price!)
        cell.layer.borderColor = UIColor.black.cgColor
        configure(with: product.thumbnail ?? "", imageView: cell.productImage)
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = (collectionView.frame.width - (numberOfColumns - 1) * 0) / numberOfColumns
        let width = (collectionView.frame.width / numberOfColumns)
        return CGSize(width: width, height: width + 30)
    }
    
    func configure(with imageUrl: String, imageView: UIImageView) {
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }.resume()
        }
    }
}
