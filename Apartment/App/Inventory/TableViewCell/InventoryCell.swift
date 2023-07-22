//
//  InventoryCell.swift
//  Apartment
//
//  Created by Shikha Sharma on 21/07/23.
//


import UIKit

class InventoryCell: UITableViewCell {
    // MARK: - UI Components
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.bold18
        label.textColor = UIColor.AppThemeColors.black0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.system14
        label.textColor = UIColor.AppThemeColors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppThemeColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(separatorView)
        
        // Constraints
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppSpace.xs),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpace.xs),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpace.xs),
            
            quantityLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: AppSpace.xxxs),
            quantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppSpace.xs),
            quantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppSpace.xs),
            
            separatorView.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: AppSpace.xs),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: AppDesignFrame.h1),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with item: InventoryItem) {
        itemNameLabel.text = item.itemName
        quantityLabel.text = "Quantity: \(item.quantity)"
    }
}
