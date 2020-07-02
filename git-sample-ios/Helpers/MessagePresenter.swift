//
//  MessagePresenter.swift
//
//  Created by Pedro Albuquerque on 24/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import UIKit
import SwiftMessages

class MessagePresenter: NSObject {
    
    static func presentMessageCard(style: Theme, message: String, title: String) {
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .none
        config.interactiveHide = true
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(style)
        view.configureContent(title: title, body: message)
        view.button?.isHidden = true
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentMessageBar(style: Theme, message: String, title: String) {
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .none
        config.interactiveHide = true
        
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureTheme(style)
        view.configureContent(title: title, body: message)
        view.button?.isHidden = true
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentMessage(style: Theme, message: String, title: String) {
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        config.interactiveHide = true
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(style)
        view.configureContent(title: title, body: message)
        view.button?.isHidden = true
        //SwiftMessages.show(view: view)
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentWarningMessage(_ bodyText: String, _ completion: ((_ finished: Bool) -> Void)? = nil) {
        
        var appName: String = "App"
        
        if let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            appName = appDisplayName
        }
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        config.interactiveHide = true
        
        // Specify one or more event listeners to respond to show and hide events.
        config.eventListeners.append { event in
            if case .didHide = event {
                //print("did hide")
                completion?(true)
            }
        }
        
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: appName, body: bodyText)
        view.tapHandler = {_ in SwiftMessages.hide()}
        //view.configureTheme(backgroundColor: UIColor.white, foregroundColor: UIColor.blueAstronaut, iconImage: UIImage(named: "ic_checkmark")?.withRenderingMode(.alwaysOriginal), iconText: nil)
        view.configureTheme(backgroundColor: UIColor.white, foregroundColor: UIColor.firstColor, iconImage: UIImage(named: "icwarning")?.withRenderingMode(.alwaysTemplate), iconText: nil)
        view.button?.isHidden = true
        view.iconImageView?.isHidden = false
        
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentSuccessMessage(_ bodyText: String, _ completion: ((_ finished: Bool) -> Void)? = nil) {
        
        var appName: String = "App"
        
        if let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            appName = appDisplayName
        }
    
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        config.interactiveHide = true
        
        // Specify one or more event listeners to respond to show and hide events.
        config.eventListeners.append { event in
            if case .didHide = event {
                //print("did hide")
                completion?(true)
            }
        }
        
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: appName, body: bodyText)
        view.tapHandler = {_ in SwiftMessages.hide()}
        view.configureTheme(.success, iconStyle: .light)
        view.button?.isHidden = true
        view.iconImageView?.isHidden = false
        
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentErrorMessageWithButton(_ bodyText: String, _ completion: ((_ finished: Bool) -> Void)? = nil) {
        
        var tryAgain: Bool = false
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = .seconds(seconds: 5)
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        config.interactiveHide = true
        
        // Specify one or more event listeners to respond to show and hide events.
        config.eventListeners.append { event in
            if case .didHide = event {
                //print("did hide")
                completion?(tryAgain)
            }
        }
        
        let view: MessageView
        view = MessageView.viewFromNib(layout: .centeredView)
        view.tintColor = UIColor.firstColor
        view.configureBackgroundView(width: 280)
        view.configureContent(title: "Oops!", body: bodyText, iconImage: UIImage(named: "ic_not_checked"), iconText: nil, buttonImage: nil, buttonTitle: "Tentar novamente", buttonTapHandler: { _ in
            tryAgain = true
            SwiftMessages.hide()
        })
        view.tapHandler = {_ in SwiftMessages.hide()}
        //view.configureTheme(backgroundColor: UIColor.white, foregroundColor: UIColor.darkText, iconImage: UIImage(named: "errorIcon")?.withRenderingMode(.alwaysTemplate), iconText: nil)
        view.button?.isHidden = false
        view.iconImageView?.isHidden = false
        
        SwiftMessages.show(config: config, view: view)
    }
    
    static func presentInfoMessageWithButton(message: String, title: String, _ completion: ((_ finished: Bool) -> Void)? = nil) {
        
        var tryAgain: Bool = false
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = .seconds(seconds: 15)
        config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        config.interactiveHide = true
        
        // Specify one or more event listeners to respond to show and hide events.
        config.eventListeners.append { event in
            if case .didHide = event {
                //print("did hide")
                completion?(tryAgain)
            }
        }
        
        let view: MessageView
        view = MessageView.viewFromNib(layout: .centeredView)
        view.tintColor = UIColor.firstColor
        view.configureBackgroundView(width: 290)
        view.configureContent(title: title, body: message, iconImage: UIImage(named: "logoWhite")?.withRenderingMode(.alwaysTemplate), iconText: nil, buttonImage: nil, buttonTitle: "OK", buttonTapHandler: { _ in
            tryAgain = true
            SwiftMessages.hide()
        })
        view.tapHandler = {_ in SwiftMessages.hide()}
        view.button?.isHidden = false
        view.iconImageView?.isHidden = false
        
        SwiftMessages.show(config: config, view: view)
    }
}
