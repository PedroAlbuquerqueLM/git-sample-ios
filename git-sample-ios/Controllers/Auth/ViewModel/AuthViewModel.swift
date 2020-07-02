//
//  LoginViewModel.swift
//
//  Created by Pedro Albuquerque on 17/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift
import Firebase

class AuthViewModel: NSObject {
    
    let responseAuth = PublishSubject<UserModel>()
    let fetchError = PublishSubject<(String)>()
    let fetchCancel = PublishSubject<(Void)>()
    
    public override init() {
        super.init()
    }
    
    func fetchAuth(email: String?, pass: String?) {
        guard let email = email, let pass = pass else {
            self.fetchError.onNext("Dados incorretos")
            return
        }
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            guard let user = authResult?.user else {
                self.fetchError.onNext(error?.localizedDescription ?? "Erro ao fazer login")
                return
            }
            let userModel = UserModel(email: user.email!, token: user.uid)
            self.responseAuth.onNext(userModel)
        }
    }
    
    func fetchAuth(credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          guard let user = authResult?.user else {
              self.fetchError.onNext(error?.localizedDescription ?? "Erro ao fazer login")
              return
          }
            let userModel = UserModel(email: user.displayName!, token: user.uid)
            self.responseAuth.onNext(userModel)
        }
    }
    
    func fetchSignup(email: String?, pass: String?) {
        guard let email = email, let pass = pass else {
            self.fetchError.onNext("Dados incompletos")
            return
        }
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            guard authResult?.user != nil else {
                self.fetchError.onNext(error?.localizedDescription ?? "Erro ao fazer o cadastro")
                return
            }
            
            MessagePresenter.presentMessage(style: .success, message: "Usuário cadastrado com sucesso!", title: "Sucesso!!!")
            
            Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
                guard let user = authResult?.user else {
                    self.fetchError.onNext(error?.localizedDescription ?? "Erro ao fazer login")
                    return
                }
                let userModel = UserModel(email: user.email!, token: user.uid)
                self.responseAuth.onNext(userModel)
            }
        }
    }
}
