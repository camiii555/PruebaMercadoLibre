//
//  LoadingViewViewController.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 29/01/24.
//

import UIKit

// Enum to define different presentation contexts for the loading view
enum PresentationContext {
    case overCurrentContext
    case overFullScreen
}

// Enum to define different loading styles (light or dark)
enum LoadingStyle {
    case light
    case dark
}

// Custom UIView subclass for a loading view
class LoadingView: UIView {
    
    // Outlets for the loading view components
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    // Variables to store the parent view and loading view
    private var parentView: UIView?
    private var loadingView: UIView?
    
    // Default initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // Required initializer when loading from a storyboard or xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Static method to show the loading view
    static func show(inView view: UIView, style: LoadingStyle, presentationContext: PresentationContext) -> LoadingView {
        let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)![0] as! LoadingView
        loadingView.initWith(view: view, style: style, presentationContext: presentationContext)
        return loadingView
    }
    
    // Private method to initialize the loading view with the specified parameters
    private func initWith(view: UIView, style: LoadingStyle, presentationContext: PresentationContext) {
        parentView = view
        setStyle(style: style)
        rotateImage()
        
        switch presentationContext {
        case .overFullScreen:
            let window = UIApplication.shared.windows.first
            window!.addSubview(self)
            window!.makeKeyAndVisible()
            frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        case .overCurrentContext:
            frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            parentView!.addSubview(self)
        }
    }
    
    // Method to hide the loading view
    func hide(animated: Bool) {
        self.removeFromSuperview()
    }
    
    // Private method to add a rotation animation to the image view
    private func rotateImage() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.isRemovedOnCompletion = false
        
        self.imageView.layer.add(rotateAnimation, forKey: nil)
    }
    
    // Private method to set the visual style of the loading view
    private func setStyle(style: LoadingStyle) {
        titleLabel.textColor = style == .light ? UIColor(hex: "999999") : .white
        blurView.effect = UIBlurEffect(style: style == .light ? .light : .dark)
        let image = UIImage(named: style == .light ? "icon_spinner_black" : "icon_spinner_white")
        imageView.image = image
    }
    
}

