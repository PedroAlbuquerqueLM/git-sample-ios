//
//  SessionManager.swift
//
//  Created by Pedro Albuquerque on 30/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

class SessionManager {
    
    class func loggedVerify() {
        guard let user =  UserModel.getUser() else {
            let navigationController = UINavigationController(rootViewController: LoginViewController(viewModel: AuthViewModel()))
            navigationController.navigationBar.isHidden = true
            appDelegate?.window?.rootViewController = navigationController
            appDelegate?.window?.makeKeyAndVisible()
            return
        }
        APIManager.sharedInstance.accessToken = user.token ?? ""
        appDelegate?.window?.rootViewController = UINavigationController(rootViewController: RepositoriesViewController(viewModel: RepositoriesViewModel()))
        appDelegate?.window?.makeKeyAndVisible()
    }
    
    class func logout() {
        UserModel.deleteUser()
        SessionManager.loggedVerify()
    }
}
