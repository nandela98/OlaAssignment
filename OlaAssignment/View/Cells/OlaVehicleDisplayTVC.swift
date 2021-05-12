//
//  OlaVehicleDisplayTVC.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit

protocol CellConfigureProtocol {
    /// common protocol method for configuring data from tableview cell for row
    /// - Parameter data: can be any data type but it should match for reading data
    func configure<T>(data: T?)
}

final class OlaVehicleDisplayTVC: UITableViewCell, CellConfigureProtocol {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var licencePlateLbl: UILabel!
    @IBOutlet weak var vehicleTypeLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure<T>(data: T?) {
        if let vehicleDetails = data as? Vehicle {
            titleLbl.text = vehicleDetails.vehicleDetails?.name ?? ""
            licencePlateLbl.text = vehicleDetails.licensePlate ?? ""
            imgView.setImage(from: URL(string: vehicleDetails.carImageURL ?? "")!)
            vehicleTypeLbl.text = vehicleDetails.innerCleanliness?.rawValue ?? ""
            colorLbl.text = vehicleDetails.vehicleDetails?.color?.rawValue ?? ""
        }
    }
    
}
