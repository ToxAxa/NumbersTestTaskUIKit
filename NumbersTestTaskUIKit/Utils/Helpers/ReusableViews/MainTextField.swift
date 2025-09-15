//
//  MainTextField.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit


final class MainTextField: UIView {
    
    // MARK: - Private Variables
    private var containerView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private var textFiled: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.cornerRadius = 10
        textField.borderWidth = 1
        textField.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.returnKeyType = .done
        textField.keyboardType = .numbersAndPunctuation

        return textField
    }()
    
    // MARK: - Public Variables
    enum ContentType {
        case empty
        case inputWithPlaceholderText(placeholderText: String)
    }
    
    var textDidChangeAction: IntAction?
    var notNumberAction: Action?
    
    var type: ContentType = .empty {
        didSet {
            prepareWithType(type)
        }
    }
    
    var returnKeyType: UIReturnKeyType = .done {
        didSet {
            textFiled.returnKeyType = returnKeyType
        }
    }
    
    var currentText: String {
        textFiled.text ?? ""
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareMainTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareMainTextField()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: - Private Methods
    private func prepareMainTextField() {
        addSubview(containerView)
        
        [textFiled].forEach({containerView.addSubview($0)})
        
        containerView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        textFiled.snp.makeConstraints({ make in
            make.height.equalTo(50)
            make.leading.trailing.top.bottom.equalToSuperview()
        })
        
        
        textFiled.delegate = self
        
        prepareWithType(type)
    }
    
    private func prepareWithType(_ type: ContentType) {
        
        switch type {
        case .empty:
            break
        case .inputWithPlaceholderText(let placeholder):
            textFiled.placeholder = placeholder
        }
    }
    
    // MARK: - Public Methods
    func clearTextField() {
        textFiled.text = ""
    }
}



extension MainTextField: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {

        if let text = textField.text, let number = Int(text) {
            textDidChangeAction?(number)
        } else {
            notNumberAction?()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            if Int(string) == nil {
                return false
            }
        }

        return true
    }
}
