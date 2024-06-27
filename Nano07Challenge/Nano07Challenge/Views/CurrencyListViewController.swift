//
//  CurrencyListViewController.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 25/06/24.
//

import UIKit

class CurrencyListViewController: UIViewController {
    // MARK: Variables
    private var vm = ViewModel()
    private var data: [String: String] = [:]
    private var filteredData: [String : String] = [:]
    private var filtered = false
    private var sortOption: SortOptions = .codeAscending
    
    // MARK: UI Components
    lazy var searchField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Start typing to search..."
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.accessibilityIdentifier = "SearchBar"
        
        return tf
    }()
    
    lazy var sortButton: UIButton = {
        let btn = UIButton()
        btn.configuration = .borderedProminent()
        btn.configuration?.attributedTitle = "Code"
        btn.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(sortButtonPress), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.id)
        
        return tableView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupUI()
        if let apiData = vm.currenciesNames {
            self.data = apiData
        } else {
            vm.fetchCurrencies()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.data = self.vm.currenciesNames ?? [:]
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Functions
    @objc func sortButtonPress() {
        changeSortOrder()
        changeButton()
    }
    
    private func sort(data: [String : String]) -> [(String, String)]{
        var dataArray = Array(data)
        
        switch sortOption {
        case .nameAscending:
            dataArray.sort { $0.1 < $1.1 }
        case .nameDescending:
            dataArray.sort { $0.1 > $1.1 }
        case .codeAscending:
            dataArray.sort { $0.0 < $1.0 }
        case .codeDescending:
            dataArray.sort { $0.0 > $1.0 }
        }
        
        return dataArray
    }
    
    private func changeSortOrder() {
        switch self.sortOption {
        case .nameAscending:
            self.sortOption = .nameDescending
        case .nameDescending:
            self.sortOption = .codeAscending
        case .codeAscending:
            self.sortOption = .codeDescending
        case .codeDescending:
            self.sortOption = .nameAscending
        }
        tableView.reloadData()
    }
    
    private func changeButton() {
        switch self.sortOption {
        case .nameAscending:
            sortButton.configuration?.attributedTitle = "Name"
            sortButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        case .nameDescending:
            sortButton.configuration?.attributedTitle = "Name"
            sortButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        case .codeAscending:
            sortButton.configuration?.attributedTitle = "Code"
            sortButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        case .codeDescending:
            sortButton.configuration?.attributedTitle = "Code"
            sortButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        }
    }
    
    private func setupUI() {
        view.addSubview(searchField)
        view.addSubview(tableView)
        view.addSubview(sortButton)
        
        NSLayoutConstraint.activate([
            self.searchField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.searchField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.searchField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            self.sortButton.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 10),
            self.sortButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        ])
    }
    
    private func search(_ query: String) {
        filteredData.removeAll()
        filtered = true
        for (key, value) in data{
            if key.lowercased().starts(with: query.lowercased()) || value.lowercased().starts(with: query.lowercased()) {
                filteredData[key] = value
            }
        }
        tableView.reloadData()
    }
    
    enum SortOptions {
        case nameAscending
        case nameDescending
        case codeAscending
        case codeDescending
    }
}

// MARK: Delegates
extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    // MARK: Search field delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if text.count <= 1 && string == "" {
                filtered = false
                tableView.reloadData()
            } else {
                search(text + string)
            }
        }
        
        return true
    }
    
    // MARK: Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered{
            return filteredData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell else { return UITableViewCell()}
        
        let tempData = filtered ? sort(data: filteredData) : sort(data: data)
        
        let content = tempData[indexPath.row]
        
        cell.configure(with: content.0, and: content.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else { return }
        guard let cellCode = cell.currencyCode.text else { return  }
        guard let cellName = cell.currencyName.text else { return  }
        guard let vc = navigationController?.viewControllers.first as? ViewController else { return }
        
        switch vc.buttonID {
        case .none:
            return
        case .one:
            vc.firstCoin.currencies = [:]
            vc.firstCoin.currencies[cellCode] = cellName
            vc.button.setTitle(cellCode, for: .normal)
        case .two:
            vc.lastCoin.currencies = [:]
            vc.lastCoin.currencies[cellCode] = cellName
            vc.buttonTwo.setTitle(cellCode, for: .normal)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.popViewController(animated: true)
    }
    
}
