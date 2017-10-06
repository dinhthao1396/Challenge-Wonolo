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
    var text = ""
    var lat = Float()
    var lng = Float()
    var urlImageCaption = ""
    var userId = ""
    var nameLocation = ""
    var locationId = ""
    init(userName: String, fullName: String, urlImageCaption: String, text: String, lat: Float, lng: Float, urlImageUser: String, userId: String, nameLocation: String, locationId: String){
        self.userName = userName
        self.fullName = fullName
        self.urlImageCaption = urlImageCaption
        self.text = text
        self.lat = lat
        self.lng = lng
        self.urlImageUser = urlImageUser
        self.userId = userId
        self.nameLocation = nameLocation
        self.locationId = locationId
    }
}

class ArrayLocation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var url: String?
    var fullName: String?
    init(coordinate: CLLocationCoordinate2D, userName: String, text: String, url: String, fullName: String) {
        self.coordinate = coordinate
        self.title = userName
        self.subtitle = text
        self.url = url
        self.fullName = fullName
    }
}

