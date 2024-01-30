//
//  ProductListViewController.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
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
        setupSearchBar()
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            // Update the number of columns in the layout during the transition
            self.updateCollectionViewLayout()
        }, completion: nil)
    }
    
    //MARK: - Private Methods
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Comienza a buscar"
    }
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
        cell.productPrice.text = FormatPriceUtility.formatNumber(num: product.price!)
        cell.layer.borderColor = UIColor.gray.cgColor
        self.configureImage(with: product.thumbnail ?? "", imageView: cell.productImage)
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / numberOfColumns)
        let height: CGFloat = 315
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "productDetailVC") as! ProductDetailViewController
        productDetailVC.product = productListViewModel.product(at: indexPath.row)
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchBar.resignFirstResponder()
            showProgress(message: "Cargando", style: .dark, presentationContext: .overCurrentContext)
            productListViewModel.fetchProducts(query: searchText) { result in
                switch result {
                case .success(_):
                    self.productListCollectionView.reloadData()
                    self.progress?.hide(animated: true)
                case .failure(let error):
                    print("Error: \(error)")
                    self.progress?.hide(animated: true)
                }
            }
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if let searchText = searchBar.text, !searchText.isEmpty {
//            //showProgress(message: "Cargando", style: .dark, presentationContext: .overCurrentContext)
//            productListViewModel.fetchProducts(query: searchText) { result in
//                switch result {
//                case .success(_):
//                    self.productListCollectionView.reloadData()
//                    //self.progress?.hide(animated: true)
//                case .failure(let error):
//                    print("Error: \(error)")
//                    //self.progress?.hide(animated: true)
//                }
//            }
//        }
//    }
}
