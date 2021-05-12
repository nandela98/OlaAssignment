//
//  OlaVehicleDataSource.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation
import UIKit

protocol OlaVehicleDataSourceProtocol: class {
    
    /// on selection tableview cell - triggers from Datasurce class
    /// - Parameter indexPath: selected indexpath
    func didSelectTableViewData(indexPath: IndexPath)
}

/**
      Datasource for Ola vehicles display list 
 */
final class OlaVehicleDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var vehicles: [String : [Vehicle]]!
    
    weak var view: OlaVehicleDataSourceProtocol?
    
    init(data: [String : [Vehicle]]? = [:], view: OlaVehicleDataSourceProtocol) {
        self.vehicles = data
        self.view = view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OlaVehiclesSheetHeaderView.identifier) as? OlaVehiclesSheetHeaderView
        let key = [String](vehicles.keys)[section]
        headerView?.configure(data: key)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view?.didSelectTableViewData(indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vehicles.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = [String](vehicles.keys)[section]
        return vehicles[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OlaVehicleDisplayTVC = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let key = [String](vehicles.keys)[indexPath.section]
        cell.configure(data: vehicles[key]?[indexPath.row])
        return cell
    }
    
}
