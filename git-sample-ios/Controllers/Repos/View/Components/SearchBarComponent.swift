//
//  SearchBarComponent.swift
//
//  Created by Pedro Albuquerque on 01/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SearchBarComponent: UIView {
    
    let searchSubject = PublishSubject<String>()
    let clearSubject = PublishSubject<Void>()
    
    lazy var container: UIView = {
        let vw = UIView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        vw.layer.shadowColor = UIColor.shadowColor.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.cornerRadius = 4
        vw.layer.shadowOffset = CGSize(width: 0, height: 0)
        return vw
    }()
    
    lazy var search: UISearchBar = {
        let label = UISearchBar(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = UIColor.firstColor
        label.delegate = self
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)

        self.backgroundColor = .clear
        
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews() {
        
        self.addSubview(container)
        container.snp.makeConstraints { (obj) in
            obj.top.equalTo(self.snp.top).offset(14)
            obj.left.equalTo(self.snp.left).offset(20)
            obj.right.equalTo(self.snp.right).offset(-20)
            obj.bottom.equalTo(self.snp.bottom).offset(-4)
        }
        
        container.addSubview(search)
        search.snp.makeConstraints { (obj) in
            obj.top.equalTo(container.snp.top).offset(0)
            obj.left.equalTo(container.snp.left).offset(14)
            obj.right.equalTo(container.snp.right).offset(-14)
            obj.bottom.equalTo(self.snp.bottom).offset(-4)
        }
        
    }
}

extension SearchBarComponent: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, text != "" else {
            self.clearSubject.onNext(())
            return
        }
        self.searchSubject.onNext(text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        self.clearSubject.onNext(())
    }
}
