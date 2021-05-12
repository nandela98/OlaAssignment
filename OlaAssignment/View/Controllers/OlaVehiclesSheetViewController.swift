//
//  OlaVehiclesSheetViewController.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit

final class OlaVehiclesSheetViewController: OlaBottomSheetPull {
    
    @IBOutlet private weak var tableView: UITableView!
    /// dataSource is the property where tableview datasource and delegates operated from
    private var dataSource: OlaVehicleDataSource?
    
    init(data: [String : [Vehicle]]) {
        super.init(nibName: "\(OlaVehiclesSheetViewController.self)", bundle: nil)
        self.dataSource = OlaVehicleDataSource(data: data, view: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    
}

// MARK: fileprivate (setUp gesture and initial setup)

fileprivate extension OlaVehiclesSheetViewController {
    
    func initialSetup() {
        assignTableviewReferenceToBaseVC()
        registerNibs()
        setTableViewDelegates()
    }
    
    /// register tableview with .xibs
    func registerNibs() {
        tableView.registerNib(OlaVehicleDisplayTVC.self)
        tableView.register(OlaVehiclesSheetHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: OlaVehiclesSheetHeaderView.identifier)
    }
    
    /// set tableview dataSource and delegate reference to
    func setTableViewDelegates() {
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.reloadData()
    }
    
    /// assign Tableview reference to baseVC for bottom sheet pulley OlaVehicleDataSource
    func assignTableviewReferenceToBaseVC() {
        self.tableVw = tableView
    }
    
}

// MARK: OlaVehicleDataSourceProtocol

extension OlaVehiclesSheetViewController: OlaVehicleDataSourceProtocol {
    
    func didSelectTableViewData(indexPath: IndexPath) {
        dismissPullView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
