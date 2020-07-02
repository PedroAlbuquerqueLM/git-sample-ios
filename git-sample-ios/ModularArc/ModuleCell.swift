//
//  ModuleCell.swift
//

import UIKit

@available(iOS 9.0, *)
class MAModuleCell: UITableViewCell {
    
    lazy var moduleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var moduleModel: UIView? {
        didSet {
            guard let view = moduleModel else {return}
            self.subviews.forEach {$0.removeFromSuperview()}
            view.translatesAutoresizingMaskIntoConstraints = false
            moduleView = view
            self.addSubview(moduleView)
            moduleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            moduleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            moduleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            moduleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        self.selectionStyle = .none
        self.separatorInset.left = 1000
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
