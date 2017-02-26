//
//  ViewController.swift
//  Example
//
//  Created by Kaique Damato on 2/25/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var loadingView: KDLoadingView!

    @IBOutlet var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func animate() {
        if loadingView.isAnimating {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
    }

}

