//
//  RepositoriesViewController+Reactive.swift
//
//  Created by Pedro Albuquerque on 28/05/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - Bind with RxCocoa
extension Reactive where Base: RepositoriesViewController {
    
    var loadList: Binder<[RepositoryModel]> {
        return Binder(base) { (view, response) in
            view.endLoadingComponent()
            if response.count > 0 {
                view.loadComponents(repos: response)
            } else {
                view.showEmptyComponent()
            }
        }
    }
    
    var showEmptyState: Binder<String> {
        return Binder(base) { (view, response) in
            view.endLoadingComponent()
            view.showEmptyComponent(title: "Ops, algo deu errado!", desc: response)
        }
    }
    
    var selectItem: Binder<RepositoryModel> {
        return Binder(base) { (view, response) in
            let vc = PullsViewController(viewModel: PullsViewModel(repository: response))
            view.navigationController?.show(vc, sender: nil)
        }
    }
    
    var searchText: Binder<String> {
        return Binder(base) { (view, response) in
            view.viewModel?.searchText = response
            view.viewModel?.repos.removeAll()
            view.clearComponents()
            view.loadData()
        }
    }
    
    var clearSearchText: Binder<Void> {
        return Binder(base) { (view, _) in
            view.viewModel?.searchText = "swift"
            view.viewModel?.repos.removeAll()
            view.clearComponents()
            view.loadData()
        }
    }
}
