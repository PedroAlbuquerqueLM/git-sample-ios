//
//  SignupViewController+Reactive.swift
//
//  Created by Pedro Albuquerque on 29/05/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth

// MARK: - Bind with RxCocoa
extension Reactive where Base: SignupViewController {
    
    var signInAction: Binder<Void> {
        return Binder(base) { (view, _) in
            view.navigationController?.popViewController(animated: true)
        }
    }
    
    var signUpAction: Binder<Void> {
        return Binder(base) { (view, _) in
            if view.validTexts() {
                view.showLoading()
                view.viewModel?.fetchSignup(email: view.emailText.field.text, pass: view.passText.field.text)
            }
        }
    }
    
    var cancelAction: Binder<Void> {
        return Binder(base) { (view, _) in
            view.hideLoading()
        }
    }
    
    var showFetchError: Binder<String> {
        return Binder(base) { (view, response) in
            view.hideLoading()
            MessagePresenter.presentMessage(style: .error, message: response, title: "Oops... Algo deu errado!")
        }
    }
    
    var auth: Binder<UserModel> {
        return Binder(base) { (view, response) in
            view.hideLoading()
            DAOManager.save(type: UserModel.self, obj: [response])
            appDelegate?.window?.rootViewController = UINavigationController(rootViewController: RepositoriesViewController(viewModel: RepositoriesViewModel()))
        }
    }
}
