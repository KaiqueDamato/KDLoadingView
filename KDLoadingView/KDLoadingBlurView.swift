//
//  KDLoadingBlurView.swift
//  KDLoadingView
//
//  Created by Rodrigo Soldi Lopes on 02/03/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import UIKit

final class KDLoadingBlurView: UIView {
    private let effectView: UIVisualEffectView
    public var loadingView : KDLoadingView?
    
    init(style: UIBlurEffect.Style, backgroundColor: UIColor? = nil) {
        self.effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        self.effectView.backgroundColor = backgroundColor
        super.init(frame: .zero)
        insertSubview(effectView, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func addSubview(_ view: UIView) {
        effectView.contentView.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        effectView.frame = bounds
    }
}
