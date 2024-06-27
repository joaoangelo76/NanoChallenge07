//
//  ViewController.swift
//  Nano07Challenge
//
//  Created by Enrique Carvalho on 24/06/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Alterar depois que o Enrique e os meninos finalizarem o resto...
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("Moeda de Origem", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "Moeda Origem"
        return button
    }()
    
    //Alterar depois que o Enrique e os meninos finalizarem o resto...
    private let buttonTwo: UIButton = {
       let buttonTwo = UIButton()
        buttonTwo.setTitle("Moeda de Destino", for: .normal)
        buttonTwo.setTitleColor(.orange, for: .normal)
        buttonTwo.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        buttonTwo.backgroundColor = .systemBlue
        buttonTwo.layer.cornerRadius = 10
        buttonTwo.accessibilityIdentifier = "Moeda Destino"
        return buttonTwo
    }()
    
    private let textFieldInput: UITextField = {
        let textFieldInput = UITextField()
        textFieldInput.placeholder = "Valor a ser convertido..."
        textFieldInput.borderStyle = .roundedRect
        textFieldInput.clearButtonMode = .whileEditing
        textFieldInput.accessibilityIdentifier = "TextField"
        return textFieldInput
    }()
    
    private let outputLabel: UILabel = {
       let outputLabel = UILabel()
        outputLabel.backgroundColor = .red
        outputLabel.textColor = .black
        outputLabel.textAlignment = .center
        outputLabel.font = .systemFont(ofSize: 18, weight: .medium)
        return outputLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldInput.delegate = self
        
        self.view.backgroundColor = .white
        
//        self.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        self.button.addTarget(self, action: #selector(didTapButtonTwo), for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.addSubview(buttonTwo)
        self.view.addSubview(textFieldInput)
        self.view.addSubview(outputLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let updatedText = text.replacingCharacters(in: range, with: string)
            updateOutput(text: updatedText)
        }
        return true
    }
    
    //Necessário alterar a função para funcionar com a conversão...
    func updateOutput(text: String){
        outputLabel.text = "Output: \(text)"
    }
    
//    @objc private func didTapButton(){
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//    }
//    
//    @objc private func didTapButtonTwo(){
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//    }
}
