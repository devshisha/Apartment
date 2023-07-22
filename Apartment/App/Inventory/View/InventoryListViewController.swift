//
//  InventoryListViewController.swift
//  Apartment
//
//  Created by Shikha Sharma on 21/07/23.
//

import UIKit

class InventoryListViewController: UIViewController {

    // MARK: - UI Components
    
    private let tableView = UITableView()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: - Properties
    
    private let addInventoryView = AddInventoryView()
    private var viewModel = InventoryViewModel()
    
    // MARK: - Variables
    
    var selectedIndex: Int!
    var selectedApartment: Apartment? {
        didSet {
            // When the selectedApartment is set, update the inventory view model with its inventory items.
            if let inventory = selectedApartment?.inventory {
                viewModel.setInventoryItems(inventory)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppThemeColors.white
        setupTitleAndBackButtoView() // Setup the custom stack view for title and back button
        setupAddInventoryView()
        setupTableView()
    }
    
    // MARK: - Set up UI
    
    private func setupTitleAndBackButtoView() {
        
        // Create a custom back button
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal) // Set the text color here
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Create a label for the title
        titleLabel.text = "Inventory List"
        titleLabel.font = UIFont.AppThemeFonts.bold18
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppSpace.xs),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppSpace.xs),
            titleLabel.heightAnchor.constraint(equalToConstant: AppDesignFrame.h45)
        ])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppSpace.xs),
            backButton.heightAnchor.constraint(equalToConstant: AppDesignFrame.h45)
        ])
    }
    
    private func setupAddInventoryView() {
        view.addSubview(addInventoryView)
        
        // Add constraints for the addInventoryView
        addInventoryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addInventoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addInventoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addInventoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // set delegates
        addInventoryView.delegate = self
    }
    
    // MARK: - Button Actions
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Initialization & Set Up of TableView
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InventoryCell.self, forCellReuseIdentifier: cellIdentifiers.InventoryCell)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addInventoryView.topAnchor)
        ])
    }
}

// MARK: - TableView delegate & datasource

extension InventoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.InventoryCell, for: indexPath) as! InventoryCell
        let item = viewModel.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
}

// MARK: - Delegate function implementatino

extension InventoryListViewController: AddInventoryViewDelegate {
    
    func didAddItem(itemName: String, quantity: Int) {
        let apartmentViewModel = viewModel.numberOfItems()
        
        // Check if the apartment already has 20 inventories
        if apartmentViewModel >= 20 {
            // Showing an alert when the maximum limit is reached
            showAlert()
            return
        }
        
        viewModel.addItem(InventoryItem(itemName: itemName, quantity: quantity))
        tableView.reloadData()
    }
    
    func showAlert() {
          let alertController = UIAlertController(title: "Alert", message: "You've reached maximum number of items in inventory.", preferredStyle: .alert)
          
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
          
          present(alertController, animated: true, completion: nil)
      }
}
