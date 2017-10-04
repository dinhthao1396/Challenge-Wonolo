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
    var isCheck: Bool
    var manageStateCheck:Bool {
        get{
            return isCheck
        }
        set{
            isCheck = newValue
        }
    }

    init(userName: String, fullName: String, follows: Int, followed: Int, urlImage: String,id: String, isCheck: Bool){
        self.userName = userName
        self.fullName = fullName
        self.follows =  String(follows)
        self.followed = String(followed)
        self.urlImage = urlImage
        self.id = id
        self.isCheck = isCheck
    }
}
