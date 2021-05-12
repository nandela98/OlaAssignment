//
//  OlaAlert.swift
//  Assignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit

/**
     Global alert for any message to display
*/
func showAlert(title: String? = "Alert", message: String, okTitle: String? = "OK", completion: @escaping (_ okPressed: Bool) -> ()?) {
    let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
        completion(true)
    }))
    
    if let topController = UIApplication.shared.topMostViewController() {
        topController.present(alertController, animated: true, completion: nil)
    } else {
//        alert.show()
    }
}
