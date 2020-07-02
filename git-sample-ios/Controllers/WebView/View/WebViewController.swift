//
//  WebViewController.swift
//

import UIKit
import SnapKit

class WebViewController: MAModuleController {
    
    var viewModel: WebViewModel?
    
    lazy var web: WebViewComponent = {
        let web = WebViewComponent()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    convenience public init(viewModel: WebViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        self.title = viewModel?.pullRequest?.title
        view.accessibilityIdentifier = "webView"
        super.viewDidLoad()
        
        self.loadComponents()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadComponents() {
        self.clearComponents()
        
        guard let link = viewModel?.pullRequest?.html_url else {return}
        self.view.addSubview(web)
        web.set(urlString: link)
        web.snp.makeConstraints { (obj) in
            obj.top.equalTo(self.view.snp.topMargin)
            obj.bottom.equalTo(self.view.snp.bottom)
            obj.left.equalTo(self.view.snp.left)
            obj.right.equalTo(self.view.snp.right)
        }
    }
}
