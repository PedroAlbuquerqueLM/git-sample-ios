//
//  MAColorButton.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class MAColorButton: UIView {
    
    weak var delegate: MAButtonDelegate?
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        btn.backgroundColor = .firstColor
        btn.setTitleColor(.white, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 27
        btn.titleLabel?.font = .avenirHeavy(15)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()
    
    init(title: String, alignment: UIControl.ContentHorizontalAlignment? = .center, margins: Int = 40, topMargin: Int = 20) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.loadSubViews(margins: margins, topMargin: topMargin)
        btn.tag = tag
        btn.setTitle(title, for: .normal)
        btn.contentHorizontalAlignment = alignment ?? .center
    }
    
    @objc func btnSelected(button: UIButton!) {
        delegate?.selected(obj: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(margins: Int, topMargin: Int) {
        
        self.addSubview(btn)
        btn.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(topMargin)).isActive = true
        let height = (ScreenSize.width - 80) * 0.15
        btn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        btn.heightAnchor.constraint(equalToConstant: height).isActive = true
        btn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CGFloat(margins)).isActive = true
        btn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(-margins)).isActive = true
        btn.layer.cornerRadius = height/2
        
    }
}
