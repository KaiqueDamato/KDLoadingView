//
//  KDLoadingViewTests.swift
//  KDLoadingViewTests
//
//  Created by Kaique Damato on 2/26/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import XCTest
@testable import KDLoadingView

class KDLoadingViewTests: XCTestCase {
    
    var sut: KDLoadingView!
    
    let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    let lineWidth = CGFloat(3.0)
    let firstColor = UIColor.gray
    let secondColor  = UIColor.groupTableViewBackground
    let thirdColor = UIColor.lightGray
    let duration = CGFloat(1.0)
    
    override func setUp() {
        sut = KDLoadingView(frame: frame,
                            lineWidth: lineWidth,
                            firstColor: firstColor,
                            secondColor: secondColor,
                            thirdColor: thirdColor,
                            duration: duration)
    }
    
    func testInit() {

        XCTAssertEqual(sut.frame, frame)
        XCTAssertEqual(sut.lineWidth, lineWidth)
        XCTAssertEqual(sut.firstColor, firstColor)
        XCTAssertEqual(sut.secondColor, secondColor)
        XCTAssertEqual(sut.thirdColor, thirdColor)
        XCTAssertEqual(sut.duration, duration)
        XCTAssertEqual(sut.isHidden, true)
    }
    
    func testConfiguringLayer() {
        
        sut.layoutSubviews()
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer else {
            XCTAssert(false, "It should have added a layer.")
            return
        }
        
        XCTAssertEqual(layer.fillColor, UIColor.clear.cgColor)
        XCTAssertEqual(layer.strokeColor, firstColor.cgColor)
        XCTAssertEqual(layer.strokeStart, 0)
        XCTAssertEqual(layer.strokeEnd, 1)
        XCTAssertEqual(layer.lineWidth, lineWidth)
        XCTAssertEqual(layer.frame, sut.bounds)
    }
    
    func testAnimationGroup() {
        
        sut.layoutSubviews()
        sut.startAnimating()
        
        XCTAssertFalse(sut.isHidden)
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer,
            let animationGroup = layer.animation(forKey: "loading") as? CAAnimationGroup else {
                XCTAssert(false, "It should have an animationGroup")
            return
        }
        
        XCTAssertEqual(animationGroup.duration, CFTimeInterval(duration))
        XCTAssertEqual(convertFromCAMediaTimingFillMode(animationGroup.fillMode), convertFromCAMediaTimingFillMode(CAMediaTimingFillMode.both))
        XCTAssertEqual(animationGroup.isRemovedOnCompletion, false)
        XCTAssertEqual(animationGroup.repeatCount, Float.infinity)
        
    }
    
    func testStrokeEndAnimations() {
    
        sut.layoutSubviews()
        sut.startAnimating()
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer,
            let animationGroup = layer.animation(forKey: "loading") as? CAAnimationGroup else {
                XCTAssert(false, "It should have an animationGroup")
                return
        }
        
        guard let animations = animationGroup.animations,
            let strokeEndAnimation = animations[0] as? CABasicAnimation else {
            XCTAssert(false, "It should have animations")
            return
        }
        
        XCTAssertEqual(strokeEndAnimation.keyPath, "strokeEnd")
        XCTAssertEqual(strokeEndAnimation.beginTime, 0)
        XCTAssertEqual(strokeEndAnimation.duration, CFTimeInterval(duration/2.0))
        XCTAssertEqual(strokeEndAnimation.fromValue as? Int, 0)
        XCTAssertEqual(strokeEndAnimation.toValue as? Int, 1)
        XCTAssertEqual(strokeEndAnimation.timingFunction, CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        
    }
    
    func testStrokeStartAnimation() {
        
        sut.layoutSubviews()
        sut.startAnimating()
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer,
            let animationGroup = layer.animation(forKey: "loading") as? CAAnimationGroup else {
                XCTAssert(false, "It should have an animationGroup")
                return
        }
        
        guard let animations = animationGroup.animations,
            let strokeStartAnimation = animations[1] as? CABasicAnimation else {
                XCTAssert(false, "It should have animations")
                return
        }
        
        XCTAssertEqual(strokeStartAnimation.keyPath, "strokeStart")
        XCTAssertEqual(strokeStartAnimation.beginTime, CFTimeInterval(duration/2.0))
        XCTAssertEqual(strokeStartAnimation.duration, CFTimeInterval(duration/2.0))
        XCTAssertEqual(strokeStartAnimation.fromValue as? Int, 0)
        XCTAssertEqual(strokeStartAnimation.toValue as? Int, 1)
        XCTAssertEqual(strokeStartAnimation.timingFunction, CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        
    }
    
    func testRotationAnimation() {
        
        sut.layoutSubviews()
        sut.startAnimating()
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer,
            let animationGroup = layer.animation(forKey: "loading") as? CAAnimationGroup else {
                XCTAssert(false, "It should have an animationGroup")
                return
        }
        
        guard let animations = animationGroup.animations,
            let rotationAnimation = animations[2] as? CABasicAnimation else {
                XCTAssert(false, "It should have animations")
                return
        }
    
        XCTAssertEqual(rotationAnimation.keyPath, "transform.rotation.z")
        XCTAssertEqual(rotationAnimation.fromValue as? Int, 0)
        XCTAssertEqual(rotationAnimation.toValue as? CGFloat, CGFloat(.pi * 2.0))
        XCTAssertEqual(rotationAnimation.timingFunction, CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
        XCTAssertEqual(rotationAnimation.repeatCount, Float.infinity)
        
    }
    
    func testColorsAnimation() {
    
        sut.layoutSubviews()
        sut.startAnimating()
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer,
            let animationGroup = layer.animation(forKey: "loading") as? CAAnimationGroup else {
                XCTAssert(false, "It should have an animationGroup")
                return
        }
        
        guard let animations = animationGroup.animations,
            let colorsAnimation = animations[3] as? CAKeyframeAnimation else {
                XCTAssert(false, "It should have animations")
                return
        }
        
        XCTAssertEqual(colorsAnimation.keyPath, "strokeColor")
        XCTAssertEqual(colorsAnimation.duration, CFTimeInterval(duration))
        XCTAssertEqual(colorsAnimation.keyTimes!, [0, 0.5, 1])
        XCTAssertEqual(colorsAnimation.values as! [CGColor], [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor])
        XCTAssertEqual(colorsAnimation.repeatCount, Float.infinity)
    }
    
    func testStoppingAnimations() {
        
        sut.layoutSubviews()
        sut.hidesWhenStopped = true
        
        guard let layer = sut.layer.sublayers?.first as? CAShapeLayer else {
            XCTAssert(false, "It should have a shapeLayer.")
            return
        }
        
        sut.startAnimating()
        
        XCTAssertFalse(sut.isHidden)
        XCTAssertNotNil(layer.animationKeys())
        
        sut.stopAnimating()
        
        XCTAssert(sut.isHidden)
        XCTAssertNil(layer.animationKeys())
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCAMediaTimingFillMode(_ input: CAMediaTimingFillMode) -> String {
	return input.rawValue
}
