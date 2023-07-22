//
//  AddInventoryViewController.swift
//  Apartment
//
//  Created by Shikha Sharma on 22/07/23.
//

import UIKit

protocol AddInventoryViewDelegate: AnyObject {
    func didAddItem(itemName: String, quantity: Int)
}

class AddInventoryView: UIView {
    // MARK: - UI Components
    
    private let itemNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Item"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppThemeFonts.system16
        label.text = "Quantity: 0"
        label.textColor = UIColor.AppThemeColors.black0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.AppThemeFonts.bold20
        button.backgroundColor = UIColor.AppThemeColors.lightGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = AppCornerRadius.s
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.AppThemeFonts.bold20
        button.backgroundColor = UIColor.AppThemeColors.lightGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = AppCornerRadius.s
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Item", for: .normal)
        button.titleLabel?.font = UIFont.AppThemeFonts.system16
        button.backgroundColor = UIColor.AppThemeColors.blue0
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = AppCornerRadius.s
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Delegate
    
    weak var delegate: AddInventoryViewDelegate?
    
    // MARK: - Properties
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "Quantity: \(quantity)"
        }
    }
    
    // MARK: - Item List
    
    private let itemList = ["Refrigerator", "Sofa", "TV", "Aircon", "Microwave", "Bed", "Side Table", "Coffee table", "Stove", "Oven", "Coffee maker", "Dryer", "Vacuum cleaner", "Iron", "Linens"]
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupItemListPickerView()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(itemNameTextField)
        addSubview(quantityLabel)
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            itemNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: AppSpace.xs),
            itemNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppSpace.xs),
            itemNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppSpace.xs),
            itemNameTextField.heightAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            
            quantityLabel.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: AppSpace.xs),
            quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppSpace.xs),
            
            minusButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            minusButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: AppSpace.xxs),
            minusButton.widthAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            minusButton.heightAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            
            plusButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: AppSpace.xxs),
            plusButton.widthAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            plusButton.heightAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            
            addButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: AppSpace.xs),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppSpace.xs),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppSpace.xs),
            addButton.heightAnchor.constraint(equalToConstant: AppDesignFrame.h40),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppSpace.xs)
        ])
    }
    
    // MARK: - Setup Item List Picker View
    
    private func setupItemListPickerView() {
        let itemListPicker = UIPickerView()
        itemListPicker.delegate = self
        itemListPicker.dataSource = self
        itemNameTextField.inputView = itemListPicker
        
        // Add a toolbar with Done button to dismiss the picker view
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor.AppThemeColors.blue0
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(itemListPickerDoneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        itemNameTextField.inputAccessoryView = toolbar
    }
    
    @objc private func itemListPickerDoneTapped() {
        itemNameTextField.resignFirstResponder()
    }
    
    // MARK: - Button Actions
    
    @objc private func addButtonTapped() {
        guard let itemName = itemNameTextField.text, !itemName.isEmpty, quantity > 0 else {
           return
        }
        
        delegate?.didAddItem(itemName: itemName, quantity: quantity)
        
        // Reset the input fields after adding an item
        itemNameTextField.text = nil
        quantity = 0
    }
    
    @objc private func minusButtonTapped() {
        quantity = max(quantity - 1, 0)
    }
    
    @objc private func plusButtonTapped() {
        quantity = min(quantity + 1, 20)
    }
}

extension AddInventoryView: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemNameTextField.text = itemList[row]
    }
}
