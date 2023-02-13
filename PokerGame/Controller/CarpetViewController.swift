//
//  EmployeesViewController.swift
//  PokerGame
//
//  Created by admin on 08/02/2023.
//

import UIKit

class CarpetViewController: UIViewController {
    
    @IBOutlet weak var tableViewCarpet: UITableView!

    lazy var viewModel = {
        CarpetViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        tableViewCarpet.delegate = self
        tableViewCarpet.dataSource = self
        tableViewCarpet.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        tableViewCarpet.separatorColor = .white
        tableViewCarpet.separatorStyle = .singleLine
        tableViewCarpet.tableFooterView = UIView()
        tableViewCarpet.allowsSelection = false

        tableViewCarpet.register(CarpetCell.nib, forCellReuseIdentifier: CarpetCell.identifier)
    }

    func initViewModel() {
        // Get employees data
        viewModel.getCards()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewCarpet.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension CarpetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: - UITableViewDataSource

extension CarpetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.carpetCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarpetCell.identifier, for: indexPath) as? CarpetCell
        else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
