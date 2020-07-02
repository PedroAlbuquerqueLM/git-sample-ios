//
//  PullsViewController.swift
//

import UIKit
import RxSwift

class PullsViewController: MAModuleController {
    
    var viewModel: PullsViewModel?
    let disposeBag = DisposeBag()
    
    convenience public init(viewModel: PullsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        self.title = viewModel?.repo?.name
        view.accessibilityIdentifier = "prsView"
        super.viewDidLoad()
        
        self.bindUI()
        self.addRefresh()
        self.loadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadData() {
        super.loadData()
        self.showLoadingComponent()
        viewModel?.fetchPulls()
    }
    
    public func bindUI() {
        
        viewModel?.responsePulls.bind(to: rx.loadList).disposed(by: disposeBag)
        viewModel?.fetchError.bind(to: rx.showEmptyState).disposed(by: disposeBag)

    }
    
    func loadComponents() {
        
        self.view.backgroundColor = .backgroundColor
        self.addComponent(view: TitleView(title: "Pull Requests"))
        viewModel?.prs.forEach {
            let prComponent = PullViewComponent(pr: $0)
            self.addComponent(view: prComponent)
            prComponent.selectSubject.bind(to: rx.selectItem).disposed(by: disposeBag)
        }
    }
    
}

extension PullsViewController: PullViewDelegate {
    func selected(pr: PullRequestModel) {
        let vc = WebViewController(viewModel: WebViewModel(pullRequest: pr))
        self.navigationController?.show(vc, sender: nil)
    }
}
