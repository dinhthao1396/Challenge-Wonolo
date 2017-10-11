//
//  ModelListFollowOrFollowed.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 10/7/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class ModelListFollowOrFollowed: NSObject {
    var userName = ""
    var fullName = ""
    var urlImage = ""
    var id = ""
    var isCheck: Bool
    
    init?(JSON: [String: Any], isCheck: Bool) {
        guard let userName = JSON["username"] as? String else { return nil }
        guard let fullName = JSON["full_name"] as? String else { return nil }
        guard let urlImage = JSON["profile_picture"] as? String else { return nil }
        guard let id = JSON["id"] as? String else { return nil }
        self.userName = userName
        self.fullName = fullName
        self.urlImage = urlImage
        self.id = id
        self.isCheck = false
    }

}
