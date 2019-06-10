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
        self.title = "User Rating: 1 star"
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 1 {
            self.title = "User Rating: \(ratingControl.value) star"
        } else {
            self.title = "User Rating: \(ratingControl.value) stars"
        }
    }
}
