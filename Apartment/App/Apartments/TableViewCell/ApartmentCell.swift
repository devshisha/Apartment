//
//  ApartmentCell.swift
//  Apartment
//
//  Created by Shikha Sharma on 21/07/23.
//

import UIKit

class ApartmentCell: UITableViewCell {
    // MARK: - UI Components
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.semiBold16
        label.textColor = UIColor.AppThemeColors.black0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let floorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.system14
        label.textColor = UIColor.AppThemeColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doorNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.system14
        label.textColor = UIColor.AppThemeColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.selectionStyle = .none
        
        contentView.addSubview(addressLabel)
        contentView.addSubview(floorLabel)
        contentView.addSubview(doorNumberLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppSpace.xxs),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpace.xs),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpace.xs),
            
            floorLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: AppSpace.xxxs),
            floorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpace.xs),
            floorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpace.xs),
            
            doorNumberLabel.topAnchor.constraint(equalTo: floorLabel.bottomAnchor, constant: AppSpace.xxxs),
            doorNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpace.xs),
            doorNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpace.xs),
            doorNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppSpace.xxs)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with apartment: Apartment) {
        addressLabel.text = "Address: \(apartment.address)"
        floorLabel.text = "Floor: \(apartment.floor)"
        doorNumberLabel.text = "Door: \(apartment.doorNumber)"
    }
}
