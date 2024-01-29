//
//  LoadingViewViewController.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 29/01/24.
//

import UIKit

enum PresentationContext {
    case overCurrentContext
    case overFullScreen
}

enum LoadingStyle {
    case light
    case dark
}


class LoadingView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    private var parentView: UIView?
    private var loadingView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func show(inView view: UIView, style: LoadingStyle, presentationContext: PresentationContext) -> LoadingView {
        let loadingView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)![0] as! LoadingView
        loadingView.initWith(view: view, style: style, presentationContext: presentationContext)
        return loadingView
    }
    
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
    
    func hide(animated: Bool) {
        self.removeFromSuperview()
    }
    
    private func rotateImage() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.isRemovedOnCompletion = false
        
        self.imageView.layer.add(rotateAnimation, forKey: nil)
    }
    
    private func setStyle(style: LoadingStyle) {
        titleLabel.textColor = style == .light ? UIColor(hex: "999999") : .white
        blurView.effect = UIBlurEffect(style: style == .light ? .light : .dark)
        let image = UIImage(named: style == .light ? "icon_spinner_black" : "icon_spinner_white")
        imageView.image = image
    }
    
}
