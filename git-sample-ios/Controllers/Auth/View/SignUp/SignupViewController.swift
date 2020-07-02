//
//  SignupViewController.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import RxSwift

class SignupViewController: MAModuleController {
    
    var viewModel: AuthViewModel?
    
    let nextButton = MAColorButton(title: "CADASTRAR")
    let signinButton = MALightButton(title: "REALIZAR O LOGIN", topMarging: 3, bottomMarging: -3)
    let emailText = MATextField(title: "EMAIL", isRequired: true, keyboardType: .emailAddress)
    let cpfText = MATextField(title: "CPF", isRequired: true, keyboardType: .numberPad)
    let passText = MATextField(title: "SENHA", isSecurity: true, isRequired: true, keyboardType: .numberPad)
    let disposeBag = DisposeBag()
    
    var savedPass = ""
    
    convenience public init(viewModel: AuthViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindUI()
        self.loadComponents()
        self.view.backgroundColor = .white
        self.setBottomBar(color: .firstColor)
        view.accessibilityIdentifier = "signupView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        self.hideNavigationBar(.white)
        emailText.field.textContentType = .username
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    public func bindUI() {
        signinButton.btn.rx.tap.bind(to: rx.signInAction).disposed(by: disposeBag)
        nextButton.btn.rx.tap.bind(to: rx.signUpAction).disposed(by: disposeBag)
        viewModel?.responseAuth.bind(to: rx.auth).disposed(by: disposeBag)
        viewModel?.fetchError.bind(to: rx.showFetchError).disposed(by: disposeBag)
        viewModel?.fetchCancel.bind(to: rx.cancelAction).disposed(by: disposeBag)
    }
    
    func loadComponents() {
        self.view.backgroundColor = .firstColor
//        self.setCentralizeComponents()
        
        signinButton.btn.setTitleColor(.white, for: .normal)
        signinButton.btn.setTitleColor(.white, for: .selected)
        signinButton.btn.titleLabel?.font = .avenirMedium(14)
        
        cpfText.field.maskString = "NNN.NNN.NNN-NN"
        passText.field.maskString = "NNNNNN"
        
        self.addComponentTop(view: MALogoComponent())
        self.addComponent(view: emailText)
        self.addComponent(view: cpfText)
        self.addComponent(view: passText)
        
        self.addComponent(view: nextButton)
        self.addComponentBottom(view: signinButton)
        
        self.bottomView.backgroundColor = .firstColor
    }
    
}
