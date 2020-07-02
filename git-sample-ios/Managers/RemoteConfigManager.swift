//
//  RemoteConfigManager.swift
//
//  Created by Pedro Albuquerque on 23/04/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import FirebaseRemoteConfig

class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    
    let remoteConfig = RemoteConfig.remoteConfig()
    func fetchRemoteConfig(key: String, completion: @escaping (String) -> Void) {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (_, error) in
            guard error == nil else { return }
            print("Got the value from Remote Config!")
            self.remoteConfig.activate(completion: { (success, error) in
                print("Remote Config Success!")
            })
            completion(self.remoteConfig.configValue(forKey: key).stringValue ?? "")
        }
    }
    
    func getLocalRemoteConfig(key: String) -> String {
        return self.remoteConfig.configValue(forKey: key).stringValue ?? ""
    }
}
