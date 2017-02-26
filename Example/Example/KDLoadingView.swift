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
    fileprivate var colors = [UIColor]()
    fileprivate var animating = false
    fileprivate var colorCount = 1
    
    public var isAnimating: Bool {
        animating = !animating
        return animating
    }
    
    @IBInspectable public var firstColor: UIColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
    
    @IBInspectable public var secondColor: UIColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
    
    @IBInspectable public var thirdColor: UIColor = #colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)

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
        self.backgroundColor = UIColor.clear
        shapeLayer.strokeColor = firstColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        shapeLayer.lineWidth = lineWidth
        colors = [firstColor, secondColor, thirdColor]
        
        self.layer.addSublayer(shapeLayer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let radius = min(self.bounds.size.width, self.bounds.size.height)/2.0 - self.shapeLayer.lineWidth / 2.0
        
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
    
    fileprivate func animateColors() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "strokeColor")
        animation.duration = 3
        animation.keyTimes = [0, 0.5, 1]
        animation.values = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor,#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).cgColor,#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor]
        animation.repeatCount = Float.infinity
        
        return animation
    }
    
    fileprivate func animateGroup() {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd(), animateStrokeStart(), animateRotation(), animateColors()]
        animationGroup.duration = 3
        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = Float.infinity
      
//        CATransaction.begin()
//        CATransaction.setCompletionBlock {
//            if self.colorCount == 2 {
//                self.shapeLayer.strokeColor = self.colors[self.colorCount].cgColor
//                self.colorCount = 0
//            } else {
//                self.shapeLayer.strokeColor = self.colors[self.colorCount].cgColor
//                self.colorCount += 1
//            }
//            self.animateGroup()
//        }
        shapeLayer.add(animationGroup, forKey: "loading")
//        CATransaction.commit()
    }
    
    public func startAnimating() {
//        setup()
        animateGroup()
    }
    
    public func stopAnimating() {
        shapeLayer.removeFromSuperlayer()
        shapeLayer.removeAllAnimations()
    }
}
