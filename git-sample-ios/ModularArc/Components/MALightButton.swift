//
//  MALightButton.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class MALightButton: UIView {
    
    weak var delegate: MAButtonDelegate?
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        btn.backgroundColor = .clear
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .avenirHeavy(15)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()
    
    init(title: String, alignment: UIControl.ContentHorizontalAlignment? = .center, topMarging: Int = 20, bottomMarging: Int = -20) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.loadSubViews(topMarging: CGFloat(topMarging), bottomMarging: CGFloat(bottomMarging))
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
    
    private func loadSubViews(topMarging: CGFloat, bottomMarging: CGFloat) {
        
        self.addSubview(btn)
        btn.topAnchor.constraint(equalTo: self.topAnchor, constant: topMarging).isActive = true
        let height = (ScreenSize.width - 80) * 0.15
        btn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomMarging).isActive = true
        btn.heightAnchor.constraint(equalToConstant: height).isActive = true
        btn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        btn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
    }
}
