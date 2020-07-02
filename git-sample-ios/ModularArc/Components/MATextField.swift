//
//  MATextField.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol MATextFieldDelegate: class {
    func selectOption(index: Int, obj: MATextField)
    func sizeText(text: String, obj: MATextField)
    func showInfo(obj: MATextField)
}

extension MATextFieldDelegate {
    func selectOption(index: Int, obj: MATextField) {}
    func sizeText(text: String, obj: MATextField) {}
    func showInfo(obj: MATextField) {}
}

protocol MAButtonDelegate: class {
    func selected(obj: Any?)
}

class MATextField: UIView {
    
    private var rightTextAnchor: NSLayoutConstraint?
    
    var isButton: Bool = false
    var isCurrency: Bool = false
    var isRequired = true
    var options: [DataCodeName]?
    var selectedIndex: Int?
    var textFieldColor: UIColor?
    var selectedObj: DataCodeName?
    var titleString = ""
    
    weak var delegate: MAButtonDelegate?
    weak var centerDelegate: MATextFieldDelegate?
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirMedium(14)
        label.textColor = .black
        return label
    }()
    
    lazy var field: SwiftMaskField = {
        var text = SwiftMaskField(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .avenirRegular(20)
        text.adjustsFontSizeToFitWidth = true
        text.minimumFontSize = 12
        text.textAlignment = .left
        text.maskString = "**************************************************************************************************************************************"
        text.borderStyle = .none
        text.textColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
        text.delegate = self
        return text
    }()
    
    lazy var separator: UIView = {
        var sep = UIView(frame: .zero)
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
        return sep
    }()
    
    init(title: String, fieldPlaceHolder: String = "", text: String? = "", isSecurity: Bool = false, isInteraction: Bool = true, isRequired: Bool = true, keyboardType: UIKeyboardType = .default) {
        super.init(frame: CGRect.zero)
        
        self.loadSubViews()
        self.title.text = title.uppercased()
        self.titleString = title.uppercased()
        self.field.placeholder = fieldPlaceHolder
        self.field.isSecureTextEntry = isSecurity
        self.field.text = text
        self.isRequired = isRequired
        self.isUserInteractionEnabled = isInteraction
        self.field.keyboardType = keyboardType
    }
    
    @objc func openInfo() {
        self.centerDelegate?.showInfo(obj: self)
    }
    
    func setError(obs: String = "", isError: Bool) {
        if isError {
            if self.field.textColor != #colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.231372549, alpha: 1) {
                self.textFieldColor = self.field.textColor ?? UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
            }
            self.field.textColor = #colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.231372549, alpha: 1)
            self.title.textColor = #colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.231372549, alpha: 1)
            self.title.text = obs != "" ? obs : self.title.text
        } else {
            guard let color = self.textFieldColor else {return}
            self.field.textColor = color
            self.title.textColor = UIColor(red: 0.43, green: 0.43, blue: 0.45, alpha: 1)
            self.title.text = titleString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews() {
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(field)
        field.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 8).isActive = true
        field.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        self.rightTextAnchor = field.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25)
        self.rightTextAnchor?.isActive = true
        
        self.addSubview(separator)
        separator.topAnchor.constraint(equalTo: self.field.bottomAnchor, constant: 8).isActive = true
        separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}

extension MATextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        self.setError(obs: "", isError: false)
        let newLength = text.count + string.count - range.length
        if newLength >= text.count {
            self.centerDelegate?.sizeText(text: text + string, obj: self)
        }
        return newLength <= self.field.maskString.count
    }

}

class DataCodeName {
    var code: String
    var name: String
    
    init(cd: String?, nm: String?) {
        self.code = cd ?? ""
        self.name = nm ?? ""
    }
}
