//
//  UserModel.swift
//
//  Created by Pedro Albuquerque on 30/03/20.
//  Copyright © 2020 Pedro Albuquerque. All rights reserved.
//

import Foundation
import HandyJSON
import RealmSwift

class UserModel: Object, HandyJSON {
    required init() {}
    
    @objc dynamic var id: Int = 0
    @objc dynamic var email: String?
    @objc dynamic var token: String?
    
    init(email: String, token: String) {
        self.email = email
        self.token = token
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getUser() -> UserModel? {
        let saved = DAOManager.get(type: UserModel.self) as? [UserModel]
        return saved?.first
    }
    
    static func deleteUser() {
        DAOManager.clear(type: UserModel.self)
    }
}
