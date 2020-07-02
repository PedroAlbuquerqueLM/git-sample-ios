//
//  ModelController+Extension.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit

extension MAModuleController {
    func validTexts() -> Bool {
        var isValid = true
        self.componentViews.forEach { sec in
            sec.components.forEach { comp in
                isValid = self.verifyText(vw: comp) ?? isValid
                if let side = comp as? MASideBySide {
                    isValid = self.verifyText(vw: side.leftView) ?? isValid
                    isValid = self.verifyText(vw: side.rightView) ?? isValid
                }
            }
        }
        return isValid
    }
    
    func removeErroTexts() {
        self.componentViews.forEach { sec in
            sec.components.forEach { comp in
                if let txt = comp as? MATextField {
                    txt.setError(obs: "", isError: false)
                }
                if let side = comp as? MASideBySide {
                    if let left = side.leftView as? MATextField {
                        left.setError(obs: "", isError: false)
                    }
                    if let right = side.rightView as? MATextField {
                        right.setError(obs: "", isError: false)
                    }
                }
            }
        }
    }
    
    private func verifyText(vw: UIView) -> Bool? {
        if let txt = vw as? MATextField {
            if txt.isRequired {
                if txt.field.text == "" {
                    txt.setError(obs: "", isError: true)
                    return false
                } else {
                    txt.setError(obs: "", isError: false)
                }
            }
        }
        return nil
    }
    
    func hideNavigationBar(_ tint: UIColor = .darkText) {
        guard let nvc = navigationController else { return }
        nvc.setNavigationBarHidden(false, animated: false)
        nvc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nvc.navigationBar.shadowImage = UIImage()
        nvc.navigationBar.tintColor = tint
        nvc.navigationBar.barStyle = .default
        nvc.navigationBar.backgroundColor = UIColor.clear
        nvc.navigationBar.isTranslucent = true
        nvc.navigationBar.titleTextAttributes = [.foregroundColor: tint]
        navigationItem.title = ""
    }
    
    func setNavigationBar(color: UIColor = .firstColor, tint: UIColor = .white) {
        guard let nvc = navigationController else { return }
        nvc.navigationBar.isTranslucent = false
        nvc.navigationBar.tintColor = tint
        nvc.navigationBar.backgroundColor = color
        nvc.navigationBar.barTintColor = color
        nvc.navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}
