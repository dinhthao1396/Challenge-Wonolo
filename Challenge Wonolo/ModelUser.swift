//
//  ModelUser.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class ModelUser: NSObject {
    var userName = ""
    var fullName = ""
    var follows = ""
    var followed = ""
    var urlImage = ""
    var id = ""
    
    init?(JSON: [String: Any]) {
        guard let results = JSON["data"] as? [String: Any] else { return nil }
        guard let userName = results["username"] as? String else { return nil }
        guard let fullName = results["full_name"] as? String else { return nil }
        guard let urlImage = results["profile_picture"] as? String else { return nil }
        guard let id = results["id"] as? String else { return nil }
        guard let counts = results["counts"] as? [String: Float],
            let follows = counts["follows"],
            let followed = counts["followed_by"] else { return }
        self.userName = userName
        self.fullName = fullName
        self.follows =  String(follows)
        self.followed = String(followed)
        self.urlImage = urlImage
        self.id = id
    }
}
