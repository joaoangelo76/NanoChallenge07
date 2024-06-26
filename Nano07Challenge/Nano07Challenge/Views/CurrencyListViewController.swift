//
//  CurrencyListViewController.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 25/06/24.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    // MARK: Variables
    var data: [(String, String)] = [("USD", "Dollar"), ("USD", "Dola"), ("BRL", "Reais"), ("SLA", "Sei la")]
    var filteredData: [(String, String)] = []
    var filtered = false
    
    // MARK: UI Components
    lazy var searchField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Start typing to search..."
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
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
    }
    
    // MARK: Functions
    private func setupUI() {
        view.addSubview(searchField)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.searchField.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.searchField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.searchField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
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
                filteredData.append((key, value))
            }
        }
        tableView.reloadData()
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
        
        let content: (String, String)
        if !filteredData.isEmpty && filtered{
            content = filteredData[indexPath.row]
        } else {
            content = data[indexPath.row]
        }
        
        cell.configure(with: content.0, and: content.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
