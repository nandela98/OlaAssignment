//
//  ViewController.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// segue to navigate other screen - given fullscreen support view for OlaVehicleMainViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? OlaVehicleMainViewController {
            target.modalPresentationStyle = .overCurrentContext
        }
    }

}

