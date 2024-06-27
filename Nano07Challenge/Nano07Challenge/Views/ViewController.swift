//
//  ViewController.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    var firstCoin = CurrenciesName(currencies: [:])
    var lastCoin = CurrenciesName(currencies: [:])
    var buttonID: ID = .none
    
    private var vm = ViewModel()
    
    // MARK: UI Components
    lazy var button: UIButton = {
       let button = UIButton()
        button.setTitle(firstCoin.currencies.first?.key ?? "Moeda de Origem", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .default
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonTwo: UIButton = {
       let buttonTwo = UIButton()
        buttonTwo.setTitle("Moeda de Destino", for: .normal)
        buttonTwo.setTitleColor(.systemBackground, for: .normal)
        buttonTwo.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        buttonTwo.backgroundColor = .default
        buttonTwo.layer.cornerRadius = 10
        buttonTwo.addTarget(self, action: #selector(didTapButtonTwo), for: .touchUpInside)
        return buttonTwo
    }()
    
    lazy var buttonThree: UIButton = {
       let btn = UIButton()
        btn.setTitle("Converter", for: .normal)
        btn.setTitleColor(.systemBackground, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .default
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(updateOutput), for: .touchUpInside)
        return btn
    }()
    
    lazy var textFieldInput: UITextField = {
        let textFieldInput = UITextField()
        textFieldInput.placeholder = "Valor a ser convertido..."
        textFieldInput.borderStyle = .roundedRect
        textFieldInput.clearButtonMode = .whileEditing
        textFieldInput.keyboardType = .decimalPad
        return textFieldInput
    }()
    
    lazy var outputLabel: UILabel = {
       let outputLabel = UILabel()
        outputLabel.textColor = .black
        outputLabel.textAlignment = .center
        outputLabel.font = .systemFont(ofSize: 18, weight: .medium)
        return outputLabel
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Functions
    @objc private func didTapButton(){
        self.buttonID = .one
        navigationController?.pushViewController(CurrencyListViewController(), animated: true)
    }
    
    @objc private func didTapButtonTwo(){
        self.buttonID = .two
        navigationController?.pushViewController(CurrencyListViewController(), animated: true)
    }
    
    @objc func updateOutput(){
        guard let amount = textFieldInput.text else { return }
        guard let first = firstCoin.currencies.first?.key else { return }
        guard let last = lastCoin.currencies.first?.key else { return }
        
        if let convertedAmount = vm.convert(amount: Float(amount) ?? 0, fromCurrency: first, toCurrency: last) {
            outputLabel.text = "\(first): \(amount) = \(last): \(convertedAmount)"
        } else {
            outputLabel.text = "Houve um erro, tente novamente"
        }
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(button)
        self.view.addSubview(buttonTwo)
        self.view.addSubview(buttonThree)
        self.view.addSubview(textFieldInput)
        self.view.addSubview(outputLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        buttonThree.translatesAutoresizingMaskIntoConstraints = false
        textFieldInput.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            buttonTwo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100),
            buttonTwo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 120),
            buttonTwo.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            buttonThree.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonThree.topAnchor.constraint(equalTo: self.textFieldInput.bottomAnchor, constant: 10),
            buttonThree.widthAnchor.constraint(equalToConstant: 120),
            buttonThree.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            textFieldInput.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textFieldInput.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 150),
            textFieldInput.widthAnchor.constraint(equalToConstant: 180),
            textFieldInput.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            outputLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            outputLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200),
            outputLabel.widthAnchor.constraint(equalToConstant: 300),
            outputLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    enum ID {
        case none
        case one
        case two
    }
}
