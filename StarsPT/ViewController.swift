//
//  ViewController.swift
//  StarsPT
//
//  Created by morse on 6/7/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    let customControl = CustomControl(coder: NSCoder)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        // FIXME: "star" not "stars" for 1
        self.title = "User Rating: \(ratingControl.value) stars"
    }
    
}
