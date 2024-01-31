//
//  BaseViewController.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    // Property to hold the LoadingView instance for progress indication.
    var progress: LoadingView?
    
    var showAlertHandler: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup can be performed here if needed.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Objc Methods
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Methods
    // Function to display a progress indicator with a specified message, style, and presentation context.
    func showProgress(message: String, style: LoadingStyle, presentationContext: PresentationContext) {
        // Use the LoadingView utility to show a loading indicator on the view.
        self.progress = LoadingView.show(inView: view, style: style, presentationContext: presentationContext)
        self.progress!.titleLabel.text = message
    }
    
    // Function to asynchronously load an image from a given URL and set it on a UIImageView.
    func configureImage(with imageUrl: String, imageView: UIImageView) {
        if let url = URL(string: imageUrl) {
            // Use URLSession to fetch the image data from the specified URL.
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // If data is received and an image is successfully created, update the UIImageView on the main thread.
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }.resume()
        }
    }
    
    // Function to display an alert with a given title and message.
    func showAlert(title: String, message: String) {
        // Use the injected showAlertHandler if available, otherwise, use the default implementation.
        showAlertHandler?(title, message) ?? defaultShowAlert(title: title, message: message)
    }
    
    // Default implementation of alert presentation using UIAlertController.
    private func defaultShowAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "Aceptar", style: .default)
        alertController.addAction(actionButton)
        // Present the alert on the view controller.
        self.present(alertController, animated: true)
    }
}
