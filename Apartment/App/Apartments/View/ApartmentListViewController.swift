//
//  ApartmentListViewController.swift
//  Apartment
//
//  Created by Shikha Sharma on 21/07/23.
//

import UIKit

class ApartmentListViewController: UIViewController {
    // MARK: - Model
    
    private var viewModel = ApartmentViewModel()
    
    // MARK: - UI Components
    
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppThemeColors.white
        
        // Create a label for the title
        titleLabel.text = "Apartment List"
        titleLabel.font = UIFont.AppThemeFonts.bold18
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: AppDesignFrame.h45)
        ])
        setupTableView()
        viewModel.fetchApartmentsFromJSON()
    }
    
    // MARK: - TableView UI and references
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ApartmentCell.self, forCellReuseIdentifier: cellIdentifiers.ApartmentCell)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView delegate & datasource

extension ApartmentListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfApartments()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.ApartmentCell, for: indexPath) as! ApartmentCell
        let apartment = viewModel.apartment(at: indexPath.row)
        cell.configure(with: apartment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedApartment = viewModel.apartment(at: indexPath.row)
        let inventoryListVC = InventoryListViewController()
        inventoryListVC.selectedApartment = selectedApartment
        inventoryListVC.selectedIndex = indexPath.row
        inventoryListVC.modalPresentationStyle = .fullScreen
        self.present(inventoryListVC, animated: true)
    }
}
