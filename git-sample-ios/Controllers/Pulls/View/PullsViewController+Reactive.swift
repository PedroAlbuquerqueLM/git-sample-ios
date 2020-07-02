//
//  PullsViewController+Reactive.swift
//
//  Created by Pedro Albuquerque on 29/05/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - Bind with RxCocoa
extension Reactive where Base: PullsViewController {
    
    var loadList: Binder<[PullRequestModel]> {
        return Binder(base) { (view, response) in
            view.endLoadingComponent()
            if response.count > 0 {
                view.loadComponents()
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
    
    var selectItem: Binder<PullRequestModel> {
        return Binder(base) { (view, response) in
            let vc = WebViewController(viewModel: WebViewModel(pullRequest: response))
            view.navigationController?.show(vc, sender: nil)
        }
    }
}
