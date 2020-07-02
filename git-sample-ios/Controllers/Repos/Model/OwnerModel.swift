//
//  OwnerModel.swift
//

import Foundation
import HandyJSON
import RealmSwift

class OwnerModel: Object, HandyJSON {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var login: String?
    @objc dynamic var avatar_url: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
