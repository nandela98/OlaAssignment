//
//  OlaVehiclesSheetHeaderView.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit

final class OlaVehiclesSheetHeaderView: UITableViewHeaderFooterView, CellConfigureProtocol {
        
    let titleLbl = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// adding title label for headerView - using constraints
    func configureContents() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLbl)
        titleLbl.backgroundColor = .clear
        contentView.backgroundColor = .clear
        titleLbl.font = .systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            titleLbl.heightAnchor.constraint(equalToConstant: 30),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 4),
            titleLbl.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure<T>(data: T?) {
        if let title = data as? String {
            let plainString = title.capitalizingFirstLetter()
            titleLbl.text = "Recommended" + " " + plainString + " " + "cars"
        }
    }

}
