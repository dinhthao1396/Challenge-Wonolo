//
//  AnnotationView.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 10/3/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit
import MapKit
class AnnotationView: MKAnnotationView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil) {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds;
        var isInside: Bool = rect.contains(point)
        if(!isInside) {
            for view in self.subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
class MyCusTomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var caption: String!
    var userName: String!
    var urlImageCaption: String!
    var userId: String!
    var nameLocation: String!
    var fullName: String!
    var urlImageUser: String!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
