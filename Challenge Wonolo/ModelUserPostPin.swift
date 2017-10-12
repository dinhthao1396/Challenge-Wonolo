//
//  ModelUserPost.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit
import UIKit
import MapKit
import Foundation

class ModelUserPostPin: NSObject {
    var userName = ""
    var fullName = ""
    var urlImageUser = ""
    var text: String?
    var lat = Float()
    var lng = Float()
    var urlImageCaption = ""
    var userId = ""
    var nameLocation = ""
    var locationId = ""
    init?(JSON: [String: Any]) {
        guard let user = JSON["user"] as? [String: Any],
            let fullName = user["full_name"] as? String,
            let urlImageUser = user["profile_picture"] as? String,
            let userName = user["username"] as? String,
            let userId = user["id"] as? String,
            let images = JSON["images"] as? [String: Any],
            let low = images["low_resolution"] as? [String: Any],
            let urlImageCaption = low["url"] as? String,
            //let caption = JSON["caption"] as? [String: Any],
            //let text = caption["text"] as? String,
            let location = JSON["location"] as? [String: Any],
            let lat = location["latitude"] as? Float,
            let lng = location["longitude"] as? Float,
            let nameLocation = location["name"] as? String,
            let idLocation = location["id"] as? Float else { return nil }
        if let caption = JSON["caption"] as? [String: Any] {
            if let text = caption["text"] as? String {
                self.text = text
            }
        }
        self.userName = userName
        self.fullName = fullName
        self.urlImageCaption = urlImageCaption
        self.lat = lat
        self.lng = lng
        self.urlImageUser = urlImageUser
        self.userId = userId
        self.nameLocation = nameLocation
        self.locationId = String(idLocation)
    }
}


