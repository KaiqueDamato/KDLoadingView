//
//  KDLoadingView.swift
//  Example
//
//  Created by Kaique Damato on 2/25/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import UIKit

@IBDesignable public class KDLoadingView: UIView {
    
    fileprivate var shapeLayer = CAShapeLayer()
    fileprivate var animating = false
    
    @IBInspectable public var firstColor: UIColor? {
        get {
            return UIColor(cgColor:shapeLayer.strokeColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        }
        set {
            shapeLayer.strokeColor = newValue?.cgColor
        }
    }
    
    @IBInspectable public var secondColor: UIColor?
    
    @IBInspectable public var thirdColor: UIColor?
    
    @IBInspectable public var duration: CGFloat = 3.0
    
    
    @IBInspectable public var lineWidth: CGFloat {
        get {
            return shapeLayer.lineWidth
        }
        set {
            shapeLayer.lineWidth = newValue
        }
    }
    
    public var isAnimating: Bool {
        return animating
    }
    
    @IBInspectable public var hidesWhenStopped: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public init(frame: CGRect, lineWidth: CGFloat, firstColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), secondColor: UIColor?, thirdColor: UIColor?, duration: CGFloat) {
        super.init(frame: frame)
        self.frame = frame
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.thirdColor = thirdColor
        self.duration = duration
        shapeLayer.frame = frame
        shapeLayer.lineWidth = lineWidth
        setup()
    }
    
    fileprivate func setup() {
        self.backgroundColor = UIColor.clear
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = firstColor?.cgColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        shapeLayer.lineWidth = lineWidth
        isHidden = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let radius = min(self.bounds.size.width, self.bounds.size.height)/2.0 - self.shapeLayer.lineWidth / 2.0
        
        let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = self.bounds
        isHidden = hidesWhenStopped
        
        self.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func animateStrokeEnd() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = 0
        animation.duration = CFTimeInterval(duration / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    fileprivate func animateStrokeStart() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = CFTimeInterval(duration / 2.0)
        animation.duration = CFTimeInterval(duration / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    fileprivate func animateRotation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat(M_PI * 2.0)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = Float.infinity
        
        return animation
    }
    
    fileprivate func animateColors() -> CAKeyframeAnimation {
        let colors = configureColors()
        
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.duration = CFTimeInterval(duration)
        animation.keyTimes = configureKeyTimes(colors: colors)
        animation.values = colors
        animation.repeatCount = Float.infinity
        
        return animation
    }
    
    fileprivate func animateGroup() {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd(), animateStrokeStart(), animateRotation(), animateColors()]
        animationGroup.duration = CFTimeInterval(duration)
        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = Float.infinity
        
        shapeLayer.add(animationGroup, forKey: "loading")
    }
    
    public func startAnimating() {
        animating = true
        isHidden = false
        animateGroup()
    }
    
    public func stopAnimating() {
        animating = false
        isHidden = hidesWhenStopped
        shapeLayer.removeAllAnimations()
    }
    
    fileprivate func configureColors() -> [CGColor] {
        var colors = [CGColor]()
        
        colors.append(firstColor!.cgColor)
        if secondColor != nil { colors.append(secondColor!.cgColor) }
        if thirdColor != nil { colors.append(thirdColor!.cgColor) }
        
        return colors
    }
    
    fileprivate func configureKeyTimes(colors: [CGColor]) -> [NSNumber] {
        switch colors.count {
        case 1:
            return [0]
        case 2:
            return [0, 1]
        default:
            return [0, 0.5, 1]
        }
    }
}

// Static Class Loading
extension KDLoadingView {
    
    public class func animate(lineWidth: CGFloat = 2.0, size: CGFloat = 25, duration: CGFloat = 3.0, firstColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), secondColor: UIColor? = nil, thirdColor: UIColor? = nil) {
        guard let window = UIApplication.shared.keyWindow,
            let topView = window.rootViewController?.view else {
            return
        }
        
        // Blur View
        let blurView = KDLoadingBlurView(effect: UIBlurEffect(style: .light))
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
        if let window = UIApplication.shared.keyWindow {
            guard let topView = window.rootViewController?.view else {
                return
            }
            
            for view in topView.subviews {
                if view.isKind(of: KDLoadingBlurView.self) {
                    removeLoadingBlurView(view as! KDLoadingBlurView)
                }
            }
        }
    }
    
    private class func addSubviewWithTransitionAnimation(fromView: UIView, toView: UIView) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
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

private class KDLoadingBlurView: UIVisualEffectView {
    public var loadingView : KDLoadingView?
}
