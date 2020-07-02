//
//  MASeparatorWithTitle.swift
//
//  Created by Pedro Albuquerque on 23/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class MASeparatorWithTitle: UIView {
    
    lazy var separator: UIView = {
        let sep = UIView(frame: .zero)
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8014139525)
        sep.alpha = 0.3
        return sep
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .avenirHeavy(18)
        title.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8014139525)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.backgroundColor = .white
        return title
    }()
    
    init(title: String, height: Int = 1) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.title.text = "  \(title)    "
        self.loadSubViews(height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(height: Int) {
        
        self.addSubview(separator)
        separator.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        title.heightAnchor.constraint(equalToConstant: 25).isActive = true
        title.centerXAnchor.constraint(equalTo: separator.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: separator.centerYAnchor).isActive = true
        
    }
}
