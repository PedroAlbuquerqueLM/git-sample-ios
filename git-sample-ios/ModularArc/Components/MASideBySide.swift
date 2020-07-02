//
//  MASideBySide.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

enum MASideBySideType: Int {
    case equal
    case leftSize
    case rightSize
}

class MASideBySide: UIView {
    
    var type: MASideBySideType = .equal
    
    lazy var leftView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setLeftView(left: UIView?) {
        guard let view = left else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        leftView = view
        self.addSubview(leftView)
        leftView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: ScreenSize.width * getSize().left).isActive = true
    }
    
    func setRightView(right: UIView?) {
        guard let view = right else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        rightView = view
        self.addSubview(rightView)
        rightView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightView.leftAnchor.constraint(equalTo: self.leftView.rightAnchor).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: ScreenSize.width * getSize().right).isActive = true
    }
    
    init(left: UIView, right: UIView, type: MASideBySideType = .equal) {
        super.init(frame: CGRect.zero)
        
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.type = type
        self.setLeftView(left: left)
        self.setRightView(right: right)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getSize() -> (left: CGFloat, right: CGFloat) {
        var leftPercent = 50.0/100
        var rightPercent = 50.0/100
        
        if type == .leftSize {
            leftPercent = 65.0/100
            rightPercent = 35.0/100
        } else if type == .rightSize {
            leftPercent = 35.0/100
            rightPercent = 65.0/100
        }
        
        return (left: CGFloat(leftPercent), right: CGFloat(rightPercent))
    }
}
