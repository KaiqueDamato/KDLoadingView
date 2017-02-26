//
//  ViewController.swift
//  Example
//
//  Created by Kaique Damato on 2/25/17.
//  Copyright © 2017 Kaique Damato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var loadingViews: [KDLoadingView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for loading in loadingViews {
            loading.hidesWhenStopped = true
            loading.startAnimating()
        }
    }
}

