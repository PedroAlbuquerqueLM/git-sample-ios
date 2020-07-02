//
//  RepositoriesViewModel.swift
//

import UIKit
import RxCocoa
import RxSwift

class RepositoriesViewModel {
    
    let responseRepos = PublishSubject<[RepositoryModel]>()
    let fetchError = PublishSubject<String>()
    
    var page = 1
    var repos = [RepositoryModel]()
    var searchText = "swift"
    
    func addPage() {
        page += 1
        fetchRepos(true)
    }
    
    func fetchRepos(_ addPage: Bool = false) {
        let route = RouterManager(router: ReposRouter.getRepos(text: searchText, page: page))
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["items"].array else {
                if !HelperDevice.checkConnection(), let saved = DAOManager.get(type: RepositoryModel.self) as? [RepositoryModel], saved.count > 0 {
                    self.repos = saved
                    self.responseRepos.onNext(saved)
                } else {
                    self.fetchError.onNext(json["statusMessage"].string ?? APIManager.errorStandard)
                }
                return
            }
            
            var pageRepo = [RepositoryModel]()
            results.forEach { result in
                if let repo = RepositoryModel.create(json: result) as? RepositoryModel {
                    if !(self.repos.filter {$0.id == repo.id}.count > 0) {
                        self.repos.append(repo)
                    }
                    pageRepo.append(repo)
                }
            }
            
            DAOManager.save(type: RepositoryModel.self, obj: self.repos)
            if addPage {
                self.responseRepos.onNext(pageRepo)
            } else {
                self.responseRepos.onNext(self.repos)
            }
        }
    }
}
