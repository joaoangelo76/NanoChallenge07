//
//  CustomCell.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 25/06/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // MARK: Variables
    static let id = "CustomCellIdentifier"
    
    // MARK: UI Components
    lazy var currencyCode: UILabel = {
        let label = UILabel()
        
        label.text = "USD"
        label.textColor = .default
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var currencyName: UILabel = {
        let label = UILabel()
        
        label.text = "Dollar"
        label.textColor = .default
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    func configure(with code: String, and name: String) {
        self.currencyCode.text = code
        self.currencyName.text = name
    }
    
    private func setupUI() {
        addSubview(currencyCode)
        addSubview(currencyName)
        
        
        NSLayoutConstraint.activate([
            self.currencyCode.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.currencyCode.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            self.currencyCode.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            self.currencyName.leadingAnchor.constraint(equalTo: self.currencyCode.leadingAnchor, constant: 50),
            self.currencyName.centerYAnchor.constraint(equalTo: self.currencyCode.centerYAnchor)
            
//            currencyCode.heightAnchor.constraint(equalToConstant: 90),
//            currencyCode.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
}
