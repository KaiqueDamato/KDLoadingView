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
    fileprivate var colors = [UIColor?]()
    fileprivate var animating = false
    
    public var isAnimating: Bool {
        animating = !animating
        return animating
    }
    
    @IBInspectable public var firstColor: UIColor?
    
    @IBInspectable public var secondColor: UIColor?
    
    @IBInspectable public var thirdColor: UIColor?

    @IBInspectable public var lineWidth: CGFloat {
        get {
            return shapeLayer.lineWidth
        }
        set {
            shapeLayer.lineWidth = newValue
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeStart = 0
//        shapeLayer.strokeEnd = 0.5
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = lineWidth
        colors = [firstColor, secondColor, thirdColor]
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let radius = min(self.bounds.size.width, self.bounds.size.height)/2.0
        
        let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = self.bounds
    }
    
    fileprivate func animateStrokeEnd() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = 0
        animation.duration = 1.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    fileprivate func animateStrokeStart() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 1.5
        animation.duration = 1.5
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
    
    fileprivate func animateGroup() {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd(), animateStrokeStart(), animateRotation()]
        animationGroup.duration = 3
        animationGroup.repeatCount = Float.infinity
        
        shapeLayer.add(animationGroup, forKey: "loading")
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [animateStrokeEnd()]
////        animationGroup.duration = 1.5
//        animationGroup.isRemovedOnCompletion = false
//        animationGroup.fillMode = kCAFillModeBoth
////        animationGroup.repeatCount = Float.infinity
//        
//        shapeLayer.add(animationGroup, forKey: "stroke")
//        
////        CATransaction.begin()
////        CATransaction.setCompletionBlock {
////            if self.i == 2 {
////                self.shapeLayer.strokeColor = self.colors[self.i]
////                self.i = 0
////            } else {
////                self.shapeLayer.strokeColor = self.colors[self.i]
////                self.i += 1
////            }
////            self.animateGroup()
////        }
//        
////        CATransaction.commit()
    }
    
    public func startAnimating() {
        self.layer.addSublayer(shapeLayer)
        animateGroup()
    }
    
    public func stopAnimating() {
        shapeLayer.removeFromSuperlayer()
        shapeLayer.removeAllAnimations()
    }
}
