//
//  TableView+Configuration.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation
import UIKit

/**
    generic tableview configuration
*/
extension UITableView {
    
    func registerNib<T: UITableViewCell>(_: T.Type)  {
        let Nib = UINib(nibName: T.identifier, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.identifier)
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type)  {
        let Nib = UINib(nibName: T.identifier, bundle: nil)
        register(Nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue header or footer  with identifier: \(T.identifier)")
        }
        return headerFooterView
    }

}

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
