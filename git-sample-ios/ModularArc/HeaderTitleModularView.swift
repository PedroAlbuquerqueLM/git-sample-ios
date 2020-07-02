//
//  HeaderTitleModularView.swift
//

import UIKit

@available(iOS 9.0, *)
class MAHeaderTitleModularView: UIView {
    
    fileprivate lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .avenirBlack(25)
        title.textColor = UIColor.black
        return title
    }()
    
    init(title: String) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 50))
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.title.text = title
        self.configuraSubviews()
        
    }
    
    func configuraSubviews() {
        
        self.addSubview(title)
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
