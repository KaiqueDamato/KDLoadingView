//
//  KDLoadingExtension.swift
//  KDLoadingView
//
//  Created by Rodrigo Soldi Lopes on 02/03/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

extension KDLoadingView {
    
    public class func animate(blurStyle: UIBlurEffect.Style = .light, lineWidth: CGFloat = 2.0, size: CGFloat = 25, duration: CGFloat = 3.0, firstColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), secondColor: UIColor? = nil, thirdColor: UIColor? = nil) {
        
        guard let window = UIApplication.shared.keyWindow else {
            // If not has a UIWindow there isn't a ViewController to present loading
            // e.g. the main view wasn't loaded yet
            return
        }
        
        guard let topView = window.rootViewController?.view else  {
            // If not has a RootViewController with a View there isn't a way to present loading
            // e.g. the main view wasn't loaded yet
            return
        }
        
                
        let blurView = KDLoadingBlurView(style: blurStyle)
        blurView.frame = topView.frame
        
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        let loadingView = KDLoadingView(frame: frame, lineWidth: lineWidth, firstColor: firstColor, secondColor: secondColor, thirdColor: thirdColor, duration: duration)
        loadingView.center = blurView.center
        
        blurView.addSubview(loadingView)
        loadingView.startAnimating()
        blurView.loadingView = loadingView
        
        addSubviewWithTransitionAnimation(fromView: topView, toView: blurView)
    }
    
    public class func stop() {
        
        guard let window = UIApplication.shared.keyWindow else {
            // If not has a UIWindow there isn't a ViewController to present loading
            // e.g. the main view wasn't loaded yet
            return
        }
        
        guard let topView = window.rootViewController?.view else  {
            // If not has a RootViewController with a View there isn't a way to present loading
            // e.g. the main view wasn't loaded yet
            return
        }
        
        for view in topView.subviews {
            if let blurView = view as? KDLoadingBlurView {
                removeLoadingBlurView(blurView)
            }
        }
    }
    
    private class func addSubviewWithTransitionAnimation(fromView: UIView, toView: UIView) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.reveal
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        toView.layer.add(transition, forKey: nil)
        fromView.addSubview(toView)
    }
    
    private class func removeLoadingBlurView(_ view: KDLoadingBlurView) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            view.loadingView?.alpha = 0.0
            view.alpha = 0.0
        }, completion: { (_) in
            view.removeFromSuperview()
        })
    }
}

