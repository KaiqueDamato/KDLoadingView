//
//  ViewController.swift
//  Example
//
//  Created by Kaique Damato on 2/25/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import UIKit
import KDLoadingView

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingView: KDLoadingView!
    
    private var animating = false
    
    @IBAction func animate(_ sender: UIButton) {                
        
        if loadingView.isAnimating {
            sender.setTitle("Start Loading", for: .normal)
            loadingView.stopAnimating()
        } else {
            sender.setTitle("Stop Loading", for: .normal)
            loadingView.startAnimating()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if animating {
            animating = false
            KDLoadingView.stop()
        } else {
            animating = true
            KDLoadingView.animate(blurStyle: .dark, lineWidth: 3.0, size: 50, firstColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), secondColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        }
    }
}

