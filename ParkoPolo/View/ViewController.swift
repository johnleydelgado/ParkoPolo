//
//  ViewController.swift
//  ParkoPolo
//
//  Created by Johnley Delgado on 01/12/2018.
//  Copyright © 2018 Johnley Delgado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
}

