//
//  MapViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMaps: MKMapView!
    var locationManager = CLLocationManager()
    var listDataToShow = [ModelUserPostPin]()
    var listUserIdFromListView = [String]()
    var listUserIdAllList = [String]()
    var userId = String()
    var isAllList = 0
    var urlImageUserDetails = ""
    var userNameDetails = ""
    var fullNameDetails = ""
    var userIdDetails = ""
    var urlImageCaptionetails = ""
    var captionDetails = ""
    var nameLocationDetails = ""
    var latCenter = ""
    var lngCenter = ""
    var counterTime = 0.0
    var timer = Timer()
    var isSelectMarker = 0

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        myMaps.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Location", style: .plain, target: self, action: #selector(MapViewController.comeBackMyLocation))
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpanMake(latDelta, longDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        myMaps.setRegion(region, animated: true)
        checkDataToShow()
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if isAllList == 0 {
            print("List Mode")
        }
        if isAllList == 1 && isSelectMarker == 0 {
            latCenter = String(mapView.centerCoordinate.latitude)
            lngCenter = String(mapView.centerCoordinate.longitude)
            runTime()
        }
    }
    
    func runTime() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func timerAction() {
        counterTime = counterTime + 0.5
        if counterTime == 1.5 {
            timer.invalidate()
            loadDataAroundLocationCenter(lat: latCenter, lng: lngCenter)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAllList == 1 {
            removeAnnotation()
            timer.invalidate()
            isSelectMarker = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAllList == 1 {
            timer.invalidate()
            counterTime = 0
        }
    }
    
    func removeAnnotation() {
        let annotationsToRemove = myMaps.annotations.filter { $0 !== myMaps.userLocation }
        myMaps.removeAnnotations( annotationsToRemove )
    }

    func comeBackMyLocation() {
        if isAllList == 1 {
            timer.invalidate()
            counterTime = 0
            removeAnnotation()
        }
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        myMaps.setRegion(region, animated: true)
        myMaps.reloadInputViews()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.myMaps.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "marker")
        return annotationView
    }
    
    func checkDataToShow() {
        if isAllList == 1 {
            print("List Mode")
        } else {
            loadDataLocation(listUserId: listUserIdFromListView)
        }
    }
    
    func setDataForPin(dataArray: [ModelUserPostPin]) {
        for value in dataArray {
            myMaps.delegate = self
            myMaps.showsUserLocation = true
            let annotation = MyCusTomAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(value.lat) , longitude: Double(value.lng)))
            annotation.caption = value.text
            annotation.userName = value.userName
            annotation.urlImageCaption = value.urlImageCaption
            annotation.userId = value.userId
            annotation.fullName = value.fullName
            annotation.urlImageUser = value.urlImageUser
            annotation.nameLocation = value.nameLocation
            self.myMaps.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        if isAllList == 1 {
            isSelectMarker = 1
            timer.invalidate()
        }
        let myAnnotation = view.annotation as! MyCusTomAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutViewController", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutViewController
        calloutView.captionPin.text = myAnnotation.caption
        calloutView.userNamePin.text = myAnnotation.userName
        calloutView.userId = myAnnotation.userId
        calloutView.fullName = myAnnotation.fullName
        calloutView.urlImageUser = myAnnotation.urlImageUser
        calloutView.nameLocation = myAnnotation.nameLocation
        calloutView.urlImageCaption = myAnnotation.urlImageCaption
        let button = UIButton(frame: calloutView.frame)
        button.addTarget(self, action: #selector(MapViewController.customCalloutView(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        calloutView.imagePin.downLoadFromUrlDemoSimple(urlSimple: myAnnotation.urlImageCaption)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func customCalloutView(sender: UIButton) {
        let customCallout = sender.superview as! CustomCalloutViewController
        urlImageUserDetails = customCallout.urlImageUser
        urlImageCaptionetails = customCallout.urlImageCaption
        userNameDetails = customCallout.userNamePin.text!
        fullNameDetails = customCallout.fullName
        userIdDetails = customCallout.userId
        nameLocationDetails = customCallout.nameLocation
        captionDetails = customCallout.captionPin.text!
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails") {
            let desViewController = segue.destination as! DetailPinViewController
            desViewController.urlImageUserDetails = self.urlImageUserDetails
            desViewController.urlImageCaptionetails = self.urlImageCaptionetails
            desViewController.userNameDetails = self.userNameDetails
            desViewController.fullNameDetails = self.fullNameDetails
            desViewController.userIdDetails = self.userIdDetails
            desViewController.nameLocationDetails = self.nameLocationDetails
            desViewController.captionDetails = self.captionDetails
            
        }
    }
    
    func loadDataAroundLocationCenter(lat: String, lng: String) {
        removeAnnotation()
        listDataToShow.removeAll()
        let urlToShow = "https://api.instagram.com/v1/media/search?lat=\(lat)&lng=\(lng)&access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        print(urlToShow)
        getListUserLocation(url: urlToShow, completion: { (jsonData, success, error) in
            if jsonData == nil {
                print("Can't Access User Media")
            } else {
                for value in jsonData! {
                    let tempDataOfPost = ModelUserPostPin(JSON: value)
                    if tempDataOfPost == nil {
                        print("Nil value")
                    } else {
                        self.listDataToShow.append(tempDataOfPost!)
                    }
                self.setDataForPin(dataArray: self.listDataToShow)
                }
                print("Now, the piker in map is \(self.listDataToShow.count)")
                self.view.reloadInputViews()
                self.myMaps.reloadInputViews()
            }
        })
    }
    
    func loadDataLocation(listUserId: [String]) {
        for value in listUserId {
            let urlToShow = "https://api.instagram.com/v1/users/\(value)/media/recent/?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
            getListUserLocation(url: urlToShow, completion: { (jsonData, success, error) in
                if jsonData == nil {
                    print("Can't Access User Media")
                } else {
                    for value in jsonData! {
                        let tempDataOfPost = ModelUserPostPin(JSON: value)
                        if tempDataOfPost == nil {
                            print("Nil value")
                        } else {
                            self.listDataToShow.append(tempDataOfPost!)
                        }
                    }
                    self.setDataForPin(dataArray: self.listDataToShow)
                    self.view.reloadInputViews()
                    self.myMaps.reloadInputViews()
                }
            })
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


