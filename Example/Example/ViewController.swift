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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidesWhenStopped = true
    }
    
    @IBAction func animate(_ sender: UIButton) {
        if loadingView.isAnimating {
            sender.setTitle("Start Loading", for: .normal)
            loadingView.stopAnimating()
        } else {
            sender.setTitle("Stop Loading", for: .normal)
            loadingView.startAnimating()
        }
    }
}

