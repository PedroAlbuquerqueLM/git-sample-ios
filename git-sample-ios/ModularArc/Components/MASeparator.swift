//
//  MASeparator.swift
//
//  Created by Pedro Albuquerque on 29/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class MASeparator: UIView {
    
    lazy var separator: UIView = {
        let sep = UIView(frame: .zero)
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = .clear
        sep.alpha = 0.3
        return sep
    }()
    
    init(height: Int = 1, color: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8014139525), backgroundColor: UIColor = .clear) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = backgroundColor
        self.separator.backgroundColor = color
        self.loadSubViews(height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(height: Int) {
        
        self.addSubview(separator)
        separator.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        separator.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
    }
}
