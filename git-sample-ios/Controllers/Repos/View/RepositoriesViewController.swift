//
//  RepositoriesViewController.swift
//
//  Created by Pedro Albuquerque on 28/05/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: MAModuleController {

    var viewModel: RepositoriesViewModel?
    lazy var searchBar = SearchBarComponent()
    let disposeBag = DisposeBag()
    
    convenience public init(viewModel: RepositoriesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        self.title = "Repositories"
        view.accessibilityIdentifier = "repositoriesView"
        super.viewDidLoad()
        
        self.bindUI()
        self.addRefresh()
        self.loadData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .done, target: self, action: #selector(logout))
    }
    
    override func loadMore() {
        if HelperDevice.checkConnection() {
            viewModel?.addPage()
        }
    }
    
    override func loadData() {
        super.loadData()
        
        self.showLoadingComponent()
        viewModel?.fetchRepos()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func bindUI() {
        
        viewModel?.responseRepos.bind(to: rx.loadList).disposed(by: disposeBag)
        viewModel?.fetchError.bind(to: rx.showEmptyState).disposed(by: disposeBag)
        searchBar.searchSubject.bind(to: rx.searchText).disposed(by: disposeBag)
        searchBar.clearSubject.bind(to: rx.clearSearchText).disposed(by: disposeBag)

    }
    
    func loadComponents(repos: [RepositoryModel]) {
        self.view.backgroundColor = .backgroundColor
        self.addComponent(view: searchBar)
        repos.forEach {
            let repoComponent = RepoViewComponent(repo: $0)
            self.addComponent(view: repoComponent)
            repoComponent.selectSubject.bind(to: rx.selectItem).disposed(by: disposeBag)
        }
    }
    
    @objc func logout() {
        SessionManager.logout()
    }
}
