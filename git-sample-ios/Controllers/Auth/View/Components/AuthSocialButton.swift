//
//  AuthSocialButton.swift
//
//  Created by Pedro Albuquerque on 23/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class AuthSocialButton: UIView {
    
    weak var delegate: MAButtonDelegate?
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirMedium(12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(image: UIImage, title: String, topMargin: Int = 20) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.loadSubViews(topMargin: topMargin)
        btn.tag = tag
        btn.setImage(image, for: .normal)
        self.title.text = title
    }
    
    @objc func btnSelected(button: UIButton!) {
        delegate?.selected(obj: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(topMargin: Int) {
        
        self.addSubview(btn)
        let size = 60
        btn.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(topMargin)).isActive = true
        btn.heightAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true
        btn.widthAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true
        btn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.btn.bottomAnchor, constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
    }
}
