//
//  BaseViewController.swift
//  PruebaMercadoLibre
//
//  Created by MacBook J&J  on 28/01/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    var progress: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func showProgress(message: String, style: LoadingStyle, presentationContext: PresentationContext) {
        progress = LoadingView.show(inView: view, style: style, presentationContext: presentationContext)
        progress!.titleLabel.text = message
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
